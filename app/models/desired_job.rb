class DesiredJob < ActiveRecord::Base
  belongs_to :user

  FIELDS = DesiredJob.attribute_names - ['id', 'user_id', 'created_at', 'updated_at']
end
