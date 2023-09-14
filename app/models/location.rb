class Location < ActiveRecord::Base
  belongs_to :company
  after_validation :geocode
  before_save :set_hq
  geocoded_by :full_street_address

  class << self
    def import(csv)
      CSV.parse(csv, col_sep: ',', headers: true, header_converters: :symbol).each do |row|
        if row[:company]
          company = Company.find(row[:company])
          company.locations.build(
                                  description: row[:description],
                                  city: row[:city],
                                  country: row[:country],
                                  address: row[:address],
                                  state: row[:state],
                                  region: row[:region]
                                ).save
        end
      end
    end

    def update_from_csv(csv)
      CSV.parse(csv, col_sep: ',', headers: true, header_converters: :symbol).each do |row|
        location = Location.find(row[:id])
        hq = row[:hq].downcase == 'true'
        values = Hash[row].delete_if { |k, v| v.nil? or [:id, :created_at, :updated_at, :hq].include?(k) }.merge(hq: hq)
        location.update_attributes(values)
      end
    end
  end

  def full_street_address
    [address, city, region, country].compact.join(' ')
  end

  def set_hq
    self.hq = description.present? && !!(description =~ /(hq|headquarters)/i)
    true
  end
end
