ActiveAdmin.register Team do
  filter :id
  filter :company, as: :select, collection: Company.order(:name)
  filter :name
  filter :category, as: :select, collection: Team::CATEGORIES
  filter :division, as: :select, collection: Division.order(:name)

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
    ids = Team.update_from_csv params[:dump][:file].read
    flash[:notice] = "Updated successfully"
    redirect_to action: :index
  end

  collection_action :import_post, method: :post do
    ids = Team.import params[:dump][:file].read
    flash[:notice] = "CSV imported successfully"
    redirect_to action: :index
  end

  controller do 
    def permitted_params
      params.permit(team: [:company_id, :division_id, :name, :category, :url, :description]) 
    end    
  end

  index do
    column :id
    column :name
    column :category
    column :company
    column :division
    column :url
    column :description
    default_actions
  end

  form do |f|
    f.inputs "Team Details" do
      f.input :company, as: :select, collection: Company.order(:name)
      f.input :division, as: :select, collection: Division.order(:name)
      f.input :name
      f.input :category, as: :select, collection: Team::CATEGORIES
      f.input :url
      f.input :description
    end
    f.actions
  end
end
