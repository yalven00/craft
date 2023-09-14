class AddDefaultsToCompanies < ActiveRecord::Migration
  def change
    change_column :companies, :hiring, :boolean, default: false
    change_column :companies, :stage, :string, default: ''
    change_column :companies, :careers_page, :string, default: ''
    change_column :companies, :crunchbase, :string, default: ''
    change_column :companies, :google_finance, :string, default: ''
    change_column :companies, :wikipedia, :string, default: ''
    change_column :companies, :duedil, :string, default: ''
    change_column :companies, :glassdoor, :string, default: ''
    change_column :companies, :linkedin, :string, default: ''
    change_column :companies, :twitter, :string, default: ''
    change_column :companies, :location, :string, default: ''
    change_column :companies, :city, :string, default: ''
    change_column :companies, :region, :string, default: ''
    change_column :companies, :state, :string, default: ''
    change_column :companies, :country, :string, default: ''
    change_column :companies, :investors, :text, default: ''
    change_column :companies, :offices, :text, default: ''
    change_column :companies, :size, :integer, default: 0
    change_column :companies, :buzz, :integer, default: 0
    change_column :companies, :strength, :integer, default: 0
    change_column :companies, :employees, :integer, default: 0
    change_column :companies, :previous_employees, :integer, default: 0
    change_column :companies, :total_funding, :decimal, default: 0
    change_column :companies, :last_funding, :decimal, default: 0
    change_column :companies, :last_funding_date, :date
  end
end
