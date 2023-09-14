class ChangeTypeOfScreenshotField < ActiveRecord::Migration
  def change
    change_column :companies, :screenshot, :string
  end
end
