class UserListLineItem < ActiveRecord::Base
  belongs_to :user_list
  belongs_to :company
end
