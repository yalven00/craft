ActiveAdmin.register Company do
  filter :id
  filter :name
  filter :hidden
  filter :category, as: :select, collection: Category.order(:name)
  filter :industry, as: :select, collection: Industry.order(:name)
  filter :company_type, as: :select, collection: ['Private', 'Subsidiary', 'Public']
  filter :hiring

  fields = [
            :id, :name, :company_type, :description, :category, :site, :blog, 
            :twitter, :twitter_followers, :previous_twitter_followers, :hiring, 
            :careers_page, :crunchbase, :linkedin, :strength, :buzz, :employees, 
            :previous_employees, :founded_year, :stage, :total_funding, 
            :last_funding, :last_funding_date, :investors, :hidden, :full_description, 
            :revenue, :valuation
          ]

  controller do
    def permitted_params
      params.permit(:company => [ 
                                  :name, :company_type, :description, :category_id, :site, :blog, 
                                  :twitter, :twitter_followers, :previous_twitter_followers, :hiring, 
                                  :careers_page, :crunchbase, :wikipedia, :google_finance, :duedil, 
                                  :glassdoor, :linkedin, :strength, :buzz, :employees, :previous_employees, 
                                  :founded_year, :stage, :total_funding, :last_funding, :last_funding_date,
                                  :investors, :offices, :_destroy, :hidden, :full_description, 
                                  :revenue, :valuation
                                ])
    end

    def apply_pagination(chain)
      chain = super unless formats.include?(:csv)
      chain
    end
  end

  csv do
    fields.push(:industry).each do |field|
      if [:industry, :category].include?(field)
        column(field.to_s) do |company| 
          obj = company.send(field)
          obj.present? ? obj.name : ''
        end
      else
        column field
      end
    end
  end

  action_item only: :show do 
    link_to 'Update Information', action: 'scrape'
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
    ids = Company.update_from_csv params[:dump][:file].read
    # NotifyWorker.perform_in(ids.count * 5.seconds, ids)

    flash[:notice] = "Updated successfully"
    redirect_to action: :index
  end

  collection_action :import_post, method: :post do
    ids = Company.import params[:dump][:file].read
    NotifyWorker.perform_in(ids.count * 5.seconds, ids)

    flash[:notice] = "CSV imported successfully"
    redirect_to action: :index
  end

  member_action :scrape do
    company = Company.find(params[:id])
    company.create_worker
    flash[:notice] = "Worker for the company #{company.name} has been created"
    redirect_to action: :index
  end

  index do
    (fields - [:full_description]).each do |field|
      column field
    end
    default_actions
  end

  form do |f|
    f.inputs "Company Details" do
      f.input :name
      f.input :hidden
      f.input :company_type, as: :select, collection: Company::COMPANY_TYPES, label: "Type"
      f.input :description
      f.input :category
      f.input :site
      f.input :blog, label: 'Company Blog'
      f.input :twitter
      f.input :twitter_followers, label: 'Twitter Followers'
      f.input :previous_twitter_followers, label: 'Twitter Followers Month Ago'
      f.input :hiring
      f.input :careers_page
      f.input :crunchbase
      f.input :wikipedia
      f.input :google_finance
      f.input :duedil
      f.input :glassdoor
      f.input :linkedin
      f.input :strength
      f.input :buzz
      f.input :employees
      f.input :previous_employees, label: 'Employeers Month Ago'
      f.input :stage
      f.input :founded_year
      f.input :total_funding
      f.input :last_funding
      f.input :last_funding_date
      f.input :investors
      f.input :full_description
      f.input :revenue
      f.input :valuation
    end
    f.actions
  end
end
