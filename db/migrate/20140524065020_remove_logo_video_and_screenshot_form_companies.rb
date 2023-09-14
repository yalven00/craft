class RemoveLogoVideoAndScreenshotFormCompanies < ActiveRecord::Migration
  def change
    remove_column :companies, :logo, :string
    remove_column :companies, :video, :text
    remove_column :companies, :screenshot, :string
  end
end
