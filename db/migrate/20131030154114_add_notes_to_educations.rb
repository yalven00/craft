class AddNotesToEducations < ActiveRecord::Migration
  def change
    rename_column :educations, :description, :notes
  end
end
