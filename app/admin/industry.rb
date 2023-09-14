ActiveAdmin.register Industry do
  controller do
    def apply_pagination(chain)
      chain = super unless formats.include?(:csv)
      chain
    end
  end

  action_item only: :index do 
    link_to 'Import', action: 'import'
  end

  action_item only: :index do 
    link_to 'Clarify', action: 'clarify'
  end

  collection_action :clarify, {} { render 'admin/csv/clarify' }
  collection_action :import, {} {render 'admin/csv/import'}

  collection_action :clarify_post, method: :post do
    ids = Industry.update_from_csv params[:dump][:file].read
    flash[:notice] = "Updated successfully"
    redirect_to action: :index
  end

  collection_action :import_post, method: :post do
    ids = Industry.import params[:dump][:file].read
    flash[:notice] = "CSV imported successfully"
    redirect_to action: :index
  end

  controller do
    def permitted_params
      params.permit(:industry => [:name])
    end
  end

  config.filters = false

  index do
    column :name
    # default_actions
  end

  
  form do |f|
    f.inputs "Industry Details" do
      f.input :name
    end
    f.actions
  end
end
