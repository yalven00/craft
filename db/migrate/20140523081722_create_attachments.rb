class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :company_id
      t.string :attachment_type, default: ''
      t.string :description, default: ''
      t.text :embed, default: ''

      t.timestamps
    end
  end
end
