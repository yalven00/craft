class UserList < ActiveRecord::Base
  has_many :user_list_line_items, dependent: :destroy
  has_many :companies, through: :user_list_line_items

  def add_company(company_id)
    line_item = self.user_list_line_items.find_or_initialize_by_company_id(company_id)
    line_item.save!
  end

  def remove_company(company_id)
    line_item = self.user_list_line_items.find_by_company_id(company_id)
    line_item.destroy
  end
end
