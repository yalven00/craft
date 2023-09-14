class AddHiddenToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :hidden, :bool
  end
end
