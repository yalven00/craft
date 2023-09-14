class Goal < ActiveRecord::Base
  belongs_to :user

  default_scope {order('date ASC')}

  validates_presence_of :title, :description
end
