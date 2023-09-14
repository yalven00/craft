class Division < ActiveRecord::Base

  has_many :teams
  belongs_to :company

  class << self
    def import(csv)
      CSV.parse(csv, col_sep: ',', headers: true, header_converters: :symbol).each do |row|
        if row[:company] && row[:name]
          company = Company.find(row[:company])
          company.divisions.build(name: row[:name], description: row[:description]).save
        end
      end
    end

    def update_from_csv(csv)
      CSV.parse(csv, col_sep: ',', headers: true, header_converters: :symbol).each do |row|
        division = Division.find(row[:id])
        values = Hash[row].delete_if { |k, v| v.nil? or [:id, :created_at, :updated_at, :company].include?(k) }
        division.update_attributes(values)
      end
    end
  end
end
