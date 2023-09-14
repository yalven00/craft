class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.string :name
      t.string :company_id
      t.text :description

      t.timestamps
    end
  end
end
