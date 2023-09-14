class AddLinkToProjectAndRenameNotes < ActiveRecord::Migration
  def change
    add_column :projects, :link, :string
    rename_column :projects, :comment, :description
  end
end
