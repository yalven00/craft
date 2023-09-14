class CompaniesController < ApplicationController

  def index
    @industries = Industry.pluck(:name, :id)
    industries_hash = Hash[@industries]
    selected_industry = params[:industry] || 'On-Demand Mobile Services'
    @selected = industries_hash[selected_industry]
  end

  def search
    if params[:ceo]
      # CEO view. We show only On-Demand Mobile Services
      industry = Industry.find_by_name("On-Demand Mobile Services")
      @categories = industry.categories
      @companies = industry.companies
      @filters = {industry: "On-Demand Mobile Services", industry_id: industry.id, location: ["All"], size: ["All"], growth: ["All"]}
      @view = 'ceo'
    else
      # normal search
      @filters = extract_filters(params[:company])
      @companies = Company.search(@filters)
      @categories = @companies.categories
      @view = if params[:view].present?
                params[:view]
              else
                @categories.count > 1 ? 'grid' : 'table'
              end
    end

    respond_to do |format|
      format.js { render :search, layout: false }
    end
  end

  def show
    @company = Company.find(params[:id])
    @jobs = @company.jobs
    @maps =Gmaps4rails.build_markers(@company.locations) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
      marker.title location.description
      marker.infowindow location.description
    end
  end

  private

    def extract_filters(params)
      filters = {}
      
      filters.merge!(industry: Industry.find(params[:industry_id]).name, industry_id: params[:industry_id]) if params[:industry_id].present?
      filters.merge!(category: Category.find(params[:category_id]).name, category_id: params[:category_id]) if params[:category_id].present?

      [:location, :size, :growth].each do |filter|
        data = if params[filter]['All'] == '1' || params[filter].values.exclude?('1')
          ['All']
        else
          params[filter].select{|k, v| v == '1' }.keys
        end

        filters.merge!(filter => data)
      end
      p filters
      return filters
    end
end
