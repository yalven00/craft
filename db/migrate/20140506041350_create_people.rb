class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :surname
      t.string :title
      t.integer :company_id
      t.boolean :is_past
      t.string :permalink

      t.timestamps
    end
  end
end
