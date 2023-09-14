class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.integer :user_id
      t.integer :pid, default: 0
      t.string :company, default: ''
      t.string :title, default: ''
      t.string :location, default: ''
      t.string :position_type, default: 'full_time'
      t.date :start_date
      t.date :end_date
      t.boolean :current, default: false
      t.timestamps
    end
  end
end
