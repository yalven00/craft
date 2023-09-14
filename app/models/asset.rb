class Asset < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  scope :education, -> {where(for_model: 'education')}
  scope :projects, -> {where(for_model: 'project')}
  scope :assets, -> {where(asset_type: 'asset')}
  scope :transcripts, -> {where(asset_type: 'transcript')}
  scope :for, ->(id) { where(mid: id)}

  has_attached_file :file, path: ":rails_root/public/system/:attachment/:id/:style/:filename", url: "/system/:attachment/:id/:style/:filename"

  ASSET_TYPES = ['transcript', 'asset']
  MODELS = ['education', 'project']

  validates_presence_of :file

  def missing?
    file.url == '/files/original/missing.png'
  end

  def to_jq_params
    {
      name: self.file_file_name,
      size: self.file_file_size,
      url: self.file.url(:original),
      delete_url: "/assets/#{self.id}",
      delete_type: "DELETE"
    }
  end

  def project
    Project.find(self.mid)
  end
end
