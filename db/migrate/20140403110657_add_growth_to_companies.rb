class AddGrowthToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :growth, :float, default: 0
  end
end
