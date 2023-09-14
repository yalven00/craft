class DivisionsController < ApplicationController

  def index
    @company = Company.find(params[:company_id])
    respond_to do |format|
      format.js { render :index, layout: false}
    end
  end

  def show
    @division = Division.find(params[:id])
    respond_to do |format|
      format.js { render :show, layout: false}
    end
  end
end
