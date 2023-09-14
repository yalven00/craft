class Team < ActiveRecord::Base

  CATEGORIES = ['making', 'selling', 'doing', 'not applicable']

  belongs_to :company
  belongs_to :division
  before_create :set_company

  validates_presence_of :name, :category
  validate :name, uniqueness: {case_sensitive: false, scope: [:company_id, :division_id]}
  validates :category, inclusion: {in: CATEGORIES}

  CATEGORIES.each do |category|
    scope category.to_sym, -> {where(category: category)}
  end

  class << self
    def import(csv)
      CSV.parse(csv, col_sep: ',', headers: true, header_converters: :symbol).each do |row|
        if row[:company]
          company = Company.find(row[:company])
          team = company.teams.build(
                                      name: row[:name],
                                      category: row[:category],
                                      division_id: row[:division] || row[:division_id],
                                      url: row[:url],
                                      description: row[:description]
                                    )
          if team.save
          else
            p team.errors
          end
        end
      end
    end

    def update_from_csv(csv)
      CSV.parse(csv, col_sep: ',', headers: true, header_converters: :symbol).each do |row|
        team = Team.find(row[:id])
        division = Division.find(row[:division] || row[:division_id]) if row[:division] || row[:division_id]
        values = Hash[row].delete_if { |k, v| v.nil? or [:id, :created_at, :updated_at].include?(k) }.merge(company_id: company.id)
        values.merge!(division_id: division.id) if division
        team.update_attributes(values)
      end
    end
  end

  def set_company
    if company_id.nil? && division_id.present?
      self.company_id = division.company_id
    end
    true
  end
end
