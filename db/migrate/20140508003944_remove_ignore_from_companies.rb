class RemoveIgnoreFromCompanies < ActiveRecord::Migration
  def change
    remove_column :companies, :ignore, :string
  end
end
