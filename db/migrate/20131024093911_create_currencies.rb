class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.date :date
      t.string :code
      t.float :from_usd, precision: 4

      t.timestamps
    end
  end
end
