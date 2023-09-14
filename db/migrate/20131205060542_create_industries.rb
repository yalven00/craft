class CreateIndustries < ActiveRecord::Migration
  def change
    create_table :industries do |t|
      t.string :name, default: ''
      t.string :year, default: ''
      t.string :area_code, default: ''
      t.string :area_type, default: ''
      t.string :area, default: ''
      t.string :state, default: ''
      t.string :outlets, default: ''
      t.string :employment, default: ''
      t.string :total_wages, default: ''
      t.string :average_weekly_wage, default: ''
      t.string :average_salary, default: ''
      t.string :employment_quotient, default: ''
      t.string :total_wage_quotient, default: ''

      t.timestamps
    end
  end
end
