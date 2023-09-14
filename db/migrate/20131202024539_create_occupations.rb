class CreateOccupations < ActiveRecord::Migration
  def change
    create_table :occupations do |t|
      t.string :code
      t.string :title
      t.string :level
      t.string :group
      t.string :employees
      t.string :average_hourly
      t.string :average_annual
      t.string :percent_hourly
      t.string :percent_annual
      t.string :only
      t.string :area
      t.string :jobs
      t.date :date

      t.timestamps
    end
  end
end
