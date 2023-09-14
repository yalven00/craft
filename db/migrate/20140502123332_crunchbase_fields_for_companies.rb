class CrunchbaseFieldsForCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :full_description, :text, default: ''
    add_column :companies, :screenshot, :string, default: ''
    add_column :companies, :video, :string, default: ''
  end
end
