class CreateMedianSalaries < ActiveRecord::Migration
  def change
    create_table :median_salaries do |t|
      t.string :title
      t.string :location
      t.integer :salary
      t.timestamps
    end
  end
end
