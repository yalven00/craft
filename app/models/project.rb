class Project < ActiveRecord::Base
  belongs_to :position
  belongs_to :user

  STATUSES = ['in progress', 'not started', 'final review', 'completed']

  scope :active, -> {where(status: ['in progress', 'not started', 'final review'])}
  scope :completed, -> {where(status: 'completed')}

  before_save :set_status
  before_save :set_duration, if: :completed?

  def set_status
    self.status = 'completed' unless self.position.current?
  end

  def set_duration
    self.duration = (self.end_date - self.start_date).to_i
  end

  def complete!
    self.status = 'completed'
    self.end_date = Date.today
    self.save!
  end

  def completed?
    self.status == 'completed'
  end

  def assets
    Asset.where(asset_type: 'asset', for_model: 'project', mid: self.id)
  end
end
