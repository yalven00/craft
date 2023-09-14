class CreateEducations < ActiveRecord::Migration
  def self.up
    create_table :educations do |t|
      t.integer :start_year
      t.integer :end_year
      t.integer :user_id
      t.integer :eid, default: 0
      t.string :school, default: ''
      t.string :degree, default: ''
      t.string :field_of_study, default: ''
      t.string :grade, default: ''
      t.text :activities, default: ''
      t.text :description, default: ''
      t.timestamps
    end
  end

  def self.down
    drop_table :educations
  end
end
