class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name, default: ''
      t.string :status, default: 'in progress'
      t.string :next_steps, default: ''
      t.integer :position_id
      t.integer :duration
      t.integer :percent_of_time, default: 0
      t.date :end_date
      t.date :start_date
      t.text :comment, default: ''
      t.text :manager_comment, default: ''
      t.timestamps
    end
  end

  def self.down
    drop_table :activeprojects
  end
end
