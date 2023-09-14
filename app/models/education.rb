class Education < ActiveRecord::Base
  belongs_to :user
  has_many :terms

  def update_fields!(params)
    self.school = params.school_name
    self.start_year = params.start_date.year
    self.end_year = params.end_date.year
    self.degree = params.degree
    self.activities = params.activities
    self.field_of_study = params.field_of_study
    self.grade = params.grade
    self.notes = params.notes
    self.save
  end

  def assets
    Asset.education.assets.for(self.id)
  end

  def transcripts
    Asset.education.transcripts.for(self.id)
  end

  def has_assets?
    self.assets.present? or self.transcripts.present?
  end
end
