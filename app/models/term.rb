class Term < ActiveRecord::Base
  belongs_to :education
  has_many :grades
  accepts_nested_attributes_for :grades, :allow_destroy => true, :reject_if => :all_blank
end
