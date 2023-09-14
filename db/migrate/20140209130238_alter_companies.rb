class AlterCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :hiring, :boolean

    add_column :companies, :category, :string
    add_column :companies, :stage, :string
    add_column :companies, :careers_page, :string
    add_column :companies, :crunchbase, :string
    add_column :companies, :google_finance, :string
    add_column :companies, :wikipedia, :string
    add_column :companies, :duedil, :string
    add_column :companies, :glassdoor, :string
    add_column :companies, :linkedin, :string
    add_column :companies, :twitter_name, :string
    add_column :companies, :location, :string
    add_column :companies, :city, :string
    add_column :companies, :region, :string
    add_column :companies, :state, :string
    add_column :companies, :country, :string

    add_column :companies, :investors, :text
    add_column :companies, :people, :text
    add_column :companies, :offices, :text
    
    add_column :companies, :size, :integer
    add_column :companies, :buzz, :integer
    add_column :companies, :strength, :integer
    add_column :companies, :employees, :integer
    add_column :companies, :employees_ma, :integer
    add_column :companies, :total_fundings, :integer
    add_column :companies, :last_funding, :integer
    
    add_column :companies, :last_funding_date, :date
  end
end
