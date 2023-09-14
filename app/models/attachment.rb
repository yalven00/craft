class Attachment < ActiveRecord::Base

  belongs_to :company
  mount_uploader :file, FileUploader
  TYPES = ['File', 'Homepage Screenshot', 'Image', 'Logo', 'Embed']

  default_scope -> { order(:order) }
  scope :homepage, -> {where(attachment_type: 'Homepage Screenshot')}

  TYPES.each do |attachment_type|
    # is_embed?, is_image? etc
    define_method("is_#{attachment_type.parameterize('_')}?".to_sym) { self.attachment_type.downcase == attachment_type.downcase }
  end
end
