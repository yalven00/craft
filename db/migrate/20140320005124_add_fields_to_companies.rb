class AddFieldsToCompanies < ActiveRecord::Migration
  def change
    remove_column :companies, :category
    add_column :companies, :category_id, :integer
    add_column :companies, :num_followers_ma, :integer, default: 0
    add_column :companies, :blog_url, :string, default: ''
    add_column :companies, :teams, :string, default: ''
  end
end
