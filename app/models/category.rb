class Category < ActiveRecord::Base
  belongs_to :industry
  has_many :companies, dependent: :destroy
  validates :name, uniqueness: {scope: :industry_id}
  validates :industry_id, :name, presence: true

  class << self
    def search(params)
      where(params).map{|item| {name: item.name, id: item.id}}
    end

    def import(csv)
      CSV.parse(csv, col_sep: ',', headers: true, header_converters: :symbol).each do |row|
        if row[:industry] && row[:category]
          industry = Industry.where(name: row[:industry]).first_or_create
          industry.categories.where(name: row[:category]).first_or_create # do not create a category if it exists
        end
      end
    end

    def update_from_csv(csv)
      CSV.parse(csv, col_sep: ',', headers: true, header_converters: :symbol).each do |row|
        category = Category.find(row[:id])
        industry = if row[:industry].present?
          Industry.where(name: row[:industry]).first_or_create
        else
          category.industry
        end

        values = Hash[row]
                    .delete_if { |k, v| v.nil? or [:id, :created_at, :updated_at, :industry].include?(k) }
                    .merge(industry_id: industry.id)

        category.update_attributes(values)
      end
    end
  end
end
