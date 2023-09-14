class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string :description, default: ''
      t.has_attached_file :file
      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
