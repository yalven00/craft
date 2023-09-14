class AddOrderToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :order, :integer, default: 0
  end
end
