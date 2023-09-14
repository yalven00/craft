ActiveAdmin.register Division do
  filter :id
  filter :name
  filter :company, as: :select, collection: Company.where(company_type: 'Public').order(:name)

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
    ids = Division.update_from_csv params[:dump][:file].read
    flash[:notice] = "Updated successfully"
    redirect_to action: :index
  end

  collection_action :import_post, method: :post do
    ids = Division.import params[:dump][:file].read
    flash[:notice] = "CSV imported successfully"
    redirect_to action: :index
  end

  controller do 
    def permitted_params
      params.permit(division: [:company_id, :name, :description]) 
    end    
  end

  index do
    column :id
    column :name
    column :company
    column :description
    default_actions
  end

  form do |f|
    f.inputs "Division Details" do
      f.input :company, as: :select, collection: Company.where(company_type: 'Public').order(:name)
      f.input :name
      f.input :description
    end
    f.actions
  end
end
