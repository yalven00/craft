class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.integer :user_id
      t.string :uid, default: ''
      t.string :provider, default: ''
      t.string :secret, default: ''
      t.string :token, default: ''

      t.timestamps
    end
  end
end
