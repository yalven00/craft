class Industry < ActiveRecord::Base
  has_many :categories, dependent: :destroy
  has_many :companies, through: :categories
  validates :name, presence: true, uniqueness: true

  # def self.for_select
  #   # 'Total, all industries'
  #   ['Goods-Producing', 
  #     'Natural Resources and Mining', 'Construction', 
  #     'Manufacturing', 'Service-Providing', 
  #     'Trade, Transportation, and Utilities', 'Information', 
  #     'Financial Activities', 'Professional and Business Services', 
  #     'Education and Health Services', 'Leisure and Hospitality', 
  #     'Other Services', 'Unclassified']
  # end

  # def self.crunchbase_catagories
  #   ['Advertising', 'Analytics/Big Data', 'Art/Design', 'Automotive', 'BioTech', 'Charity/Nonprofit', 
  #     'CleanTech', 'Consulting', 'Consumer Electronics/Devices', 'Consumer Web', 'eCommerce', 
  #     'Education', 'Enterprise', 'Fashion/Clothing', 'Finance/Venture', 'Games/Entertainment', 'Government', 
  #     'Health/Fitness', 'Hospitality/Food', 'Legal', 'Local Business', 'Manufacturing', 'Medical', 'Messaging', 
  #     'Mobile/Wireless', 'Music', 'Nanotech', 'Network/Hosting', 'News/Media', 'Pets', 'Photo/Video', 
  #     'Public Relations', 'Real Estate', 'Search', 'Security', 'Semiconductor', 'Social Networking', 'Software',
  #     'Sports', 'Transportation', 'Travel', 'Other']
  # end

  # def self.find_area(query)
  #   self.select(:area).where("LOWER (area) LIKE ?", "%#{query.downcase}%").pluck(:area)
  # end

  # def self.search(params)
  #   industries = Industry.where(name: params[:industry], area: params[:area]).order('year ASC')

  #   ['employment', 'outlets', 'average_pay'].each do |field|
  #     data = industries.collect{|item| item.send(field).to_i}
  #     value = [{name: field.capitalize, data: data}].to_json
  #     instance_variable_set("@#{field}", value)
  #   end

  #   return {employment: @employment, outlets: @outlets, industry: params[:industry], description: 'Description', average_salary: @average_pay}
  # end

  class << self
    def import(csv)
      CSV.parse(csv, col_sep: ',', headers: true, header_converters: :symbol).each do |row|
        if row[:name]
          Industry.create(name: row[:name])
        end
      end
    end

    def update_from_csv(csv)
      CSV.parse(csv, col_sep: ',', headers: true, header_converters: :symbol).each do |row|
        industry = Industry.find(row[:id])
        values = Hash[row].delete_if { |k, v| v.nil? or [:id, :created_at, :updated_at].include?(k) }
        division.update_attributes(values)
      end
    end
  end
end
