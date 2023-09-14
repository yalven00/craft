class AddTicketToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :ticket, :string, default: ''
  end
end
