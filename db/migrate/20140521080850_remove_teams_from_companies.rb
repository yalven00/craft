class RemoveTeamsFromCompanies < ActiveRecord::Migration
  def change
    remove_column :companies, :teams, :string
  end
end
