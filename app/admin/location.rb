ActiveAdmin.register Location do
  filter :id
  filter :company, as: :select, collection: Company.order(:name)
  filter :description
  filter :hq
  filter :city
  filter :country
  filter :address
  filter :state
  filter :region

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
    ids = Location.update_from_csv params[:dump][:file].read
    flash[:notice] = "Updated successfully"
    redirect_to action: :index
  end

  collection_action :import_post, method: :post do
    ids = Location.import params[:dump][:file].read
    flash[:notice] = "CSV imported successfully"
    redirect_to action: :index
  end

  controller do 
    def permitted_params
      params.permit(location: [:description, :city, :country, :address, :state, :region, :latitude, :longitude, :company_id, :hq]) 
    end    

    def scoped_collection
      resource_class.includes(:company).references(:company)
    end
  end

  index do
    column :id
    column :company, sortable: 'companies.name'
    column :description
    column :city
    column :country
    column :address
    column :state
    column :region
    column :latitude
    column :longitude
    column :hq
    default_actions
  end

  form do |f|
    f.inputs "Location Details" do
      f.input :company
      f.input :description
      f.input :city
      f.input :country, as: :string
      f.input :address
      f.input :state
      f.input :region
      f.input :latitude
      f.input :longitude
      f.input :hq
    end
    f.actions
  end
end
