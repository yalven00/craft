class Transcript < ActiveRecord::Base
  belongs_to :education
  has_attached_file :file, path: ":rails_root/public/system/:attachment/:id/:style/:filename", url: "/system/:attachment/:id/:style/:filename"

  validates_presence_of :file

  def missing?
    file.url == '/files/original/missing.png'
  end

  def to_jq_params
    {
      "name" => read_attribute(:transcript_file_name),
      "size" => read_attribute(:transcript_file_size),
      "url" => self.file.url(:original),
      "delete_url" => "/transcripts/#{self.id}",
      "delete_type" => "DELETE"
    }
  end
end
