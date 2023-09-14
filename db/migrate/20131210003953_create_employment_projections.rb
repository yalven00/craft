class CreateEmploymentProjections < ActiveRecord::Migration
  def change
    create_table :employment_projections do |t|
      t.string :code
      t.string :projection
      t.string :category
      t.string :number_change
      t.string :employment
      t.string :percent_change
      t.string :jobs

      t.timestamps
    end
  end
end
