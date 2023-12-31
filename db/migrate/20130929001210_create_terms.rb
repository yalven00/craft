class CreateTerms < ActiveRecord::Migration
  def self.up
    create_table :terms do |t|
      t.string :semester, default: ''
      t.integer :year
      t.integer :education_id
      t.timestamps
    end
  end

  def self.down
    drop_table :terms
  end
end
