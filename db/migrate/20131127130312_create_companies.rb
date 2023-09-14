class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.text :email_domains, default: ''
      t.text :industries, default: ''
      t.text :employee_count_range, default: ''
      t.text :locations, default: ''
      t.text :specialties, default: ''
      t.text :status, default: ''
      t.text :company_type, default: ''
      t.text :description, default: ''
      t.string :name, default: ''
      t.string :universal_name, default: ''
      t.string :ticker, default: ''
      t.string :website_url, default: ''
      t.string :logo_url, default: ''
      t.string :square_logo_url, default: ''
      t.string :blog_rss_url, default: ''
      t.string :twitter_id, default: ''
      t.string :stock_exchange, default: ''
      t.string :founded_year, default: ''
      t.string :end_year, default: ''
      t.integer :lid
      t.integer :num_followers, default: 0

      t.timestamps
    end
  end
end
