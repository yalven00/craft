class Person < ActiveRecord::Base

  mount_uploader :photo, PhotoUploader

  scope :current, -> { where(is_past: false) }

  belongs_to :company
  before_save :set_photo, on: :create

  class << self
    def import(csv)
      CSV.parse(csv, col_sep: ',', headers: true, header_converters: :symbol).each do |row|
        if row[:company]
          company = Company.find(row[:company])
          company.people.build(
                                name: row[:name],
                                surname: row[:surname],
                                title: row[:title],
                                is_past: row[:is_past].downcase == 'true',
                                permalink: row[:permalink]
                                ).save
        end
      end
    end

    def update_from_csv(csv)
      CSV.parse(csv, col_sep: ',', headers: true, header_converters: :symbol).each do |row|
        person = Person.find(row[:id])
        is_past = row[:is_past].downcase == 'true'
        values = Hash[row].delete_if { |k, v| v.nil? or [:id, :created_at, :updated_at, :company, :is_past].include?(k) }.merge(is_past: is_past)
        person.update_attributes(values)
      end
    end
  end

  def full_name
    [name, surname].join(' ')
  end

  def set_photo
    data = Crunchbase::Person.find_photo(self.permalink)
    if data && data['items'].present?
      path = data['items'].first['path']
      self.remote_photo_url = "http://images.crunchbase.com/#{path}"
    end
  end
end
