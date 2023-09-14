class CreateUserListLineItems < ActiveRecord::Migration
  def change
    create_table :user_list_line_items do |t|
      t.integer :user_list_id
      t.integer :company_id

      t.timestamps
    end
  end
end
