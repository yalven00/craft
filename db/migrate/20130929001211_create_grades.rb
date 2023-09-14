class CreateGrades < ActiveRecord::Migration
  def self.up
    create_table :grades do |t|
      t.string :name, default: ''
      t.string :number, default: ''
      t.string :grade, default: ''
      t.integer :term_id
      t.timestamps
    end
  end

  def self.down
    drop_table :grades
  end
end
