class AddIgnoreToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :ignore, :text, default: ''
  end
end
