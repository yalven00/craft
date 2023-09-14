class AddRevenueAndValuationToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :revenue, :decimal, default: 0
    add_column :companies, :valuation, :decimal, default: 0
  end
end
