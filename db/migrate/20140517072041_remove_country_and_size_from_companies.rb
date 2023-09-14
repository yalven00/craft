class RemoveCountryAndSizeFromCompanies < ActiveRecord::Migration
  def change
    remove_column :companies, :country, :string
    remove_column :companies, :size, :string
  end
end
