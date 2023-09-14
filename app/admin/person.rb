ActiveAdmin.register Person do
  filter :id
  filter :company, as: :select, collection: Company.order(:name)
  filter :title
  filter :name
  filter :surname
  filter :permalink
  filter :is_past

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
    ids = Person.update_from_csv params[:dump][:file].read
    flash[:notice] = "Updated successfully"
    redirect_to action: :index
  end

  collection_action :import_post, method: :post do
    ids = Person.import params[:dump][:file].read
    flash[:notice] = "CSV imported successfully"
    redirect_to action: :index
  end

  controller do 
    def permitted_params
      params.permit(person: [:name, :surname, :title, :is_past, :permalink, :company_id, :photo])
    end

    def scoped_collection
      resource_class.includes(:company).references(:company)
    end
  end

  index do
    column :id
    column :company, sortable: 'companies.name'
    column :name
    column :surname
    column :title
    column :is_past
    column :permalink
    column :photo
    default_actions
  end

  form do |f|
    f.inputs "Person Details" do
      f.input :company
      f.input :name
      f.input :surname
      f.input :title
      f.input :is_past
      f.input :permalink
      f.input :photo
    end
    f.actions
  end
end
