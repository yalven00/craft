class Position < ActiveRecord::Base
  belongs_to :user
  has_many :projects
  # has_many :compensations

  scope :past, -> {where(current: false)}
  scope :current, -> {where(current: true)}
  scope :full_time, -> {where(position_type: 'full_time')}
  scope :consulting, -> {where(position_type: 'consulting')}

  before_save :set_current
  after_create :create_compensation

  def update_fields!(params)
    self.company = params.company.name
    self.title = params.title
    self.start_date = Date.from_hash(params.start_date)
    self.end_date = Date.from_hash(params.end_date) if params.end_date.present?
    self.save!
  end

  def set_current
    self.current = false
    if self.end_date.present?
      self.current = true if self.end_date > Date.today
    else
      self.current = true
    end
    return true
  end

  def self.for_select
    select(:id, :title).collect{|position|[position.title, position.id]}
  end

  def self.compensations
    Compensation.where('position_id IN (?)', self.pluck(:id))
  end

  def end!
    self.end_date = Date.today
    self.current = false
    self.projects.each{|project| project.complete!}
    self.save!
  end

  def create_compensation
    params = { title: self.title, position_type: self.position_type, company: self.company, location: self.location, start_date: self.start_date }
    compensation = self.user.compensations.build(params)
    compensation.save!
  end
end
