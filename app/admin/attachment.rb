ActiveAdmin.register Attachment do
  filter :company, as: :select, collection: Company.order(:name)
  filter :attachment_type, as: :select, collection: Attachment::TYPES

  controller do
    def permitted_params
      params.permit(attachment: [:description, :company_id, :attachment_type, :embed, :file, :order])
    end
  end

  index do
    column :id
    column :company
    column :description
    column :attachment_type
    column :embed
    column :file
    column :order
    default_actions
  end

  form do |f|
    f.inputs "Attachment Details" do
      f.input :company, as: :select, collection: Company.order(:name)
      f.input :description
      f.input :attachment_type, as: :select, collection: Attachment::TYPES
      f.input :embed
      f.input :file
      f.input :order
    end
    f.actions
  end
end
