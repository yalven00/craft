class ChangeTeamsField < ActiveRecord::Migration
  def change
    change_column :companies, :teams, :text, default: ''
  end
end
