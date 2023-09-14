class CreateCompensations < ActiveRecord::Migration
  def change
    create_table :compensations do |t|
      t.string :currency, default: 'USD'
      t.string :title, default: ''
      t.string :rate_type, default: 'hour'
      t.string :notes, default: ''
      t.string :equity, default: ''
      t.string :position_type, default: 'full_time'
      t.string :company, default: ''
      t.string :location, default: ''
      t.date :start_date
      t.date :end_date
      t.integer :user_id
      t.integer :bonus, default: 0
      t.integer :number, default: 0
      t.integer :percent_of_target, default: 0.0
      t.float :actual_paid, default: 0.0
      t.float :target, default: 0.0
      t.float :base_salary, default: 0
      t.float :total, default: 0
      t.float :annual_equivalent, default: 0.0
      t.float :rate, default: 0.0
      t.timestamps
    end
  end
end
