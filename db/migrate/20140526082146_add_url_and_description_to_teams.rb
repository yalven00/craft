class AddUrlAndDescriptionToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :url, :string, default: ''
    add_column :teams, :description, :text, default: ''
  end
end
