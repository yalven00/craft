class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :company_id
      t.integer :division_id
      t.string :name
      t.string :category

      t.timestamps
    end
  end
end
