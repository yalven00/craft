class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :company_id
      t.string :description, default: ''
      t.string :city, default: ''
      t.string :country, default: ''
      t.string :address, default: ''
      t.string :state, default: ''
      t.string :region, default: ''
      t.float :latitude, default: 0
      t.float :longitude, default: 0
      t.boolean :hq, default: false

      t.timestamps
    end
  end
end
