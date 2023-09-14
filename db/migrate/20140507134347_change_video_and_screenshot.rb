class ChangeVideoAndScreenshot < ActiveRecord::Migration
  def change
    change_column :companies, :video, :text, default: ''
    change_column :companies, :screenshot, :text, default: ''
  end
end
