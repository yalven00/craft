class AddDefaultValueToHidden < ActiveRecord::Migration
  def change
    change_column :companies, :hidden, :bool, default: false
  end
end
