class School < ActiveRecord::Base
  has_many :terms
  has_many :assets
  has_many :transcripts
  accepts_nested_attributes_for :terms, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :assets, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :transcripts, :allow_destroy => true, :reject_if => :all_blank
end
