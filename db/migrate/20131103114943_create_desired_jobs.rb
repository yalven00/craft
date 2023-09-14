class CreateDesiredJobs < ActiveRecord::Migration
  def change
    create_table :desired_jobs do |t|
      t.string :company, default: ''
      t.string :industry, default: ''
      t.string :title, default: ''
      t.string :location, default: ''
      t.string :link, default: ''
      t.text :description, default: ''
      t.integer :user_id

      t.timestamps
    end
  end
end
