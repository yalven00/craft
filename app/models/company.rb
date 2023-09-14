class Company < ActiveRecord::Base

  belongs_to :category
  has_one :industry, through: :category
  has_many :locations, dependent: :destroy
  has_many :people, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :divisions, dependent: :destroy
  has_many :attachments, dependent: :destroy

  after_commit :create_worker, on: :create
  before_save :set_growth
  validates :name, uniqueness: true
  # validates :category_id, presence: true
  scope :in_category, ->(category_id){ where(category_id: category_id) }

  COMPANY_TYPES = ['Public', 'Division', 'Private']

  class << self
    def import(csv)
      ids = []
      CSV.parse(csv, col_sep: ',').each do |row|
        if row[0]
          company = Company.where(name: row[0], hidden: true).first_or_create
          ids << company.id
        end
      end
      ids
    end

    def update_from_csv(csv)
      ids = []
      CSV.parse(csv, col_sep: ',', headers: true, header_converters: :symbol).each do |row|
        id = row[:id]
        company = Company.find(id)
        if row[:industry].present?
          industry = Industry.where(name: row[:industry]).first_or_create
          category = Category.where(name: row[:category], industry_id: industry.id).first_or_create
        else
          category = Category.find_by_name(row[:category]) if row[:category]
        end
        hidden = row[:hidden].downcase == 'true'
        values = Hash[row]
                    .delete_if { |k, v| v.nil? or [:id, :created_at, :updated_at, :category, :industry, :last_funding_date, :hidden].include?(k) }
                    .merge(hidden: hidden)

        values.merge!(category_id: category.id) if category

        company.update_attributes(values)
      end[:id] # will return all ids
    end

    def search(filters)
      companies = Company.where(hidden: false).industry(filters[:industry_id])
                    .category(filters[:category_id])
                    .by_size(filters[:size])
                    .location(filters[:location])
                    .growth(filters[:growth])
                    # .type(params[:type])
      companies
    end

    def category(category_id = nil)
      category_id.present? ? where(category_id: category_id) : all
    end

    def categories
      self.count
      Category.where(id: self.pluck(:category_id).uniq || [])
    end

    def industry(industry_id = nil)
      industry_id.present? ? joins(:category).where(categories: {industry_id: industry_id}) : all
    end

    def by_size(size = [])
      return all if size.include?('All')

      min = size.min.split('-').first
      max = size.max.split('-').last
      if max == min or max.match /\+/
        companies = Company.where('employees >= ?', min.to_i)
      else
        companies = Company.where('employees BETWEEN ? AND ?', min.to_i, max.to_i)
      end
    end

    def location(location = [])
      return all if location.include?('All')

      sf = location.delete('SF Bay Area')
      if sf
        location += ['San Francisco', 'Mountain View', 'San Jose', 'Los Gatos', 
                    'Sunnyvale', 'San Mateo', 'Redwood City']
      end

      joins(:locations).where(locations: {city: location})
    end

    def growth(growth = [])
      return all if growth.include?('All')
      query = []

      if growth.include? 'High-growth'
        query << 'growth > 10'
      end

      if growth.include? 'Growing'
        query << 'growth > 2'
      end

      if growth.include? 'Stable'
        query << 'growth BETWEEN -2 AND 2'
      end

      if growth.include? 'Downsizing'
        query << 'growth < -2'
      end

      where(query.join(' OR '))
    end

    def type(type = [])
      return all if type.include?('All')

      where(company_type: type)
    end

    def to_csv
      CSV.generate do |csv|
        csv << column_names.map{|n| n.humanize} + ['Industry']
        all.each do |company|
          industry_name = company.industry.present? ? company.industry.name : ''
          csv << company.attributes.values_at(*column_names).push(industry_name)
        end
      end
    end
  end

  # def industry
  #   category.present? ? category.industry : nil
  # end

  def create_worker
    CompaniesWorker.perform_at(Time.now, id)
  end

  def scrape_data!
    begin
      scrape_crunchbase_data!
    rescue Crunchbase::CrunchException
      logger.error("Crunchbase::CrunchException: Unknown company (ID #{id})")
    end

    get_screenshots
    get_video
    get_logo

    begin
      find_twitter!
    rescue
    end

    unless twitter.blank?
      scrape_twitter_data!
    end

    if careers_page.blank?
      find_careers_page!
    end

    # begin
    #   scrape_linkedin_data!
    # rescue Exception => e  
    #   logger.error("#{e.message} (ID #{id})")
    # end

    hiring = careers_page.present?

    save!
  end

  def find_crunchbase!
    begin
      data = Crunchbase::Company.find(name)
      crunchbase = data.crunchbase_url
    rescue Crunchbase::CrunchException
      return
    end
    crunchbase
  end

  def scrape_crunchbase_data!
    data = crunchbase_data

    scrape_people

    if data
      self.crunchbase = data.crunchbase_url if crunchbase.blank?
      self.blog = data.blog_url if blog.blank?
      self.twitter = data.twitter_username if twitter.blank?
      self.site = data.homepage_url if site.blank?
      self.full_description = data.overview if full_description.blank?
      self.description = data.description if description.blank?
      self.investors = data.funding_rounds.map do |fr|

        # Find last funding date and amount
        date = Date.new(fr['funded_year'], fr['funded_month'], fr['funded_day']) if fr['funded_year'] && fr['funded_month'] && fr['funded_day']
        if date and !self.last_funding_date || date > self.last_funding_date
          self.last_funding_date = date
          self.last_funding = fr['raised_amount'] || 0
          self.stage = fr['round_code'].capitalize if fr['round_code'].present?
        end

        fr['investments'].map do |investment|
          if investment['company']
            investment['company']['name']
          elsif investment['financial_org']
            investment['financial_org']['name']
          elsif investment['person']
            investment['person']['first_name'] + investment['person']['last_name']
          else
            ''
          end
        end
      end.flatten.uniq.join(', ')

      self.total_funding = data.funding_rounds.inject(0) do |sum, item|
        sum += item['raised_amount'] || 0
      end

      scrape_locations

      true
    end
  end

  def get_screenshots
    # Will take a screen shot from company site in the future
    # But for now we scrape it from Crunchbase
    screenshots = crunchbase_data.screenshots
    unless screenshots.blank?
      urls = screenshots.first['available_sizes'].map{|i| i.last}
      urls.each do |url|
        begin
          attachment = self.attachments.where(attachment_type: 'Homepage Screenshot').first_or_create
          attachment.remote_file_url = url
          attachment.save!
        rescue
          next
        end
      end
    end
  end

  def get_video
    embeds = crunchbase_data.video_embeds
    unless embeds.blank?
      embeds.each do |item|
        attachment = self.attachments.where(attachment_type: 'Embed', embed: item['embed_code']).first_or_create
        attachment.description = item['description'] if item['description']
        attachment.save!
      end
    end
  end

  def get_logo
    attachment = self.attachments.where(attachment_type: 'Logo').first_or_create
    attachment.remote_file_url = twitter_data.profile_image_uri.to_s
    attachment.save!
  end

  def crunchbase_data
    @crunchbase_data ||= Crunchbase::Company.find(name)
  end

  def scrape_people
    crunchbase_data.relationships.each do |relationship|
      self.people.where(
        name: relationship.person_first_name,
        surname: relationship.person_last_name,
        title: relationship.title,
        is_past: relationship.is_past?, 
        permalink: relationship.person_permalink
        ).first_or_create
    end
  end

  def scrape_locations
    data = crunchbase_data
    data.offices.each do |office|
      address = office['address1']
      address << ", #{office['address2']}" unless office['address2'].blank?
      locations.where(
                      country: office['country_code'], 
                      city: office['city'], 
                      address: address, 
                      state: office['state_code'],
                      description: office['description']
                    ).first_or_create
    end
  end

  def find_twitter!
    return unless twitter.blank?
    result = twitter_client.user_search(self.name)
    self.twitter = result.first.username if result.first
  end

  def scrape_twitter_data!
    error_count = 0

    begin
      update_twitter_followers!(twitter_data)
      self.description = twitter_data.description
    rescue Twitter::Error, Timeout::Error => e
      if error_count < 3
        logger.error("Twitter scrapeer error: #{e}, retrying...")
        error_count += 1
        retry
      else
        return
      end
    end
  end

  def twitter_data
    @twitter_data = twitter_client.user(twitter)
  end

  # def scrape_linkedin_data!
  #   client = linkedin_client
  #   linkedin_id = client.search({keywords: self.name}, "company")
  #                       .companies.all
  #                       .find{|i| i.name.downcase == self.name.downcase }.id
  #   company_data = client.company(id: linkedin_id, fields: ['universal-name', 'num-followers'])
  #   self.linkedin ||= company_data.universal_name
  #   self.previous_employees = self.employees
  #   self.employees = scrape_linkedin_employees
  # end

  # def scrape_linkedin_employees
  #   profile = Linkedin::Company.get_profile(self.linkedin)
  #   self.employees = profile.employees
  # end

  def tweets
    twitter_client.search("from:#{self.twitter}", :result_type => "recent")
  end

  def update_twitter_followers!(data)
    self.previous_twitter_followers = self.twitter_followers if self.twitter_followers
    self.twitter_followers = data.followers_count
  end

  def twitter_client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
      # config.bearer_token     = ENV['TWITTER_BEARER_TOKEN']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
  end

  # def linkedin_client
  #   @linkedin_client ||= Authentication.where(provider: "linkedin").take.authorize_user
  # end

  def find_careers_page!
    return if site.blank? || !careers_page.blank?

    url = URI.parse(self.site)
    req = Net::HTTP.new(url.host, url.port)
    ['careers', 'career', 'jobs', 'job'].each do |path|
      res = req.request_head("#{url.path}/#{path}")
      if ['200', '302', '301'].include?(res.code)
        self.careers_page = "#{self.site}/#{path}"
        return
      end
    end
    self.careers_page
  end

  def set_growth
    if employees && previous_employees
      growth = (previous_employees - employees ) / employees.to_f * 100.0
    end
  end

  def jobs
    result = AngellistApi.search(name, type: 'Startup')
    company_hash = result.find{|item| item[:name] == name}
    company_hash.present? ? AngellistApi.get_startup_jobs(company_hash[:id]) : []
  end

  def city
    hq = locations.where(hq: true).take
    hq ? hq.city : ''
  end

  def screenshot
    attachment = attachments.where(attachment_type: 'Homepage Screenshot').first
    attachment.file.url if attachment
  end

  def logo
    attachment = attachments.where(attachment_type: 'Logo').first
    attachment.file.url if attachment
  end

  def media
    attachments.where.not(attachment_type: ['Homepage Screenshot', 'Logo'])
  end

  def ceo_photo
    ceo.present? ? ceo.photo.url : nil
  end

  def ceo
    @ceo ||= people.where("title LIKE '%CEO%'").first
  end
end
