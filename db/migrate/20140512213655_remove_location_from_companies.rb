class RemoveLocationFromCompanies < ActiveRecord::Migration
  def change
    remove_column :companies, :location, :string
    remove_column :companies, :city, :string
    remove_column :companies, :region, :string
    remove_column :companies, :state, :string
    remove_column :companies, :offices, :string
  end
end
