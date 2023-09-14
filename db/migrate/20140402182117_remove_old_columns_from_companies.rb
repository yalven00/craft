class RemoveOldColumnsFromCompanies < ActiveRecord::Migration
  def change
    # rename
    rename_column :companies, :website_url, :site
    rename_column :companies, :blog_url, :blog
    rename_column :companies, :num_followers_ma, :previous_twitter_followers
    rename_column :companies, :num_followers, :twitter_followers
    rename_column :companies, :total_fundings, :total_funding
    rename_column :companies, :employees_ma, :previous_employees
    rename_column :companies, :twitter_name, :twitter

    # remove
    remove_column :companies, :end_year
    remove_column :companies, :lid
    remove_column :companies, :twitter_id
    remove_column :companies, :stock_exchange
    remove_column :companies, :logo_url
    remove_column :companies, :square_logo_url
    remove_column :companies, :email_domains
    remove_column :companies, :industries
    remove_column :companies, :employee_count_range
    remove_column :companies, :locations
    remove_column :companies, :specialties
    remove_column :companies, :status
    remove_column :companies, :universal_name
    remove_column :companies, :ticker
    remove_column :companies, :blog_rss_url
    remove_column :companies, :people

  end
end
