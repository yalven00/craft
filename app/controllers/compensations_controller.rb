class CompensationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @full_time = current_user.compensations.full_time.order(:start_date)
    @consulting = current_user.compensations.consulting.order(:start_date)
  end

  def new
    @compensation = current_user.compensations.build(position_type: params[:type])
    respond_to do |format|
      format.js { render :new, layout: false }
    end
  end

  def create
    @compensation = current_user.compensations.build(compensation_params)
    if @compensation.save
      respond_to do |format|
        format.js { render :create, layout: false }
      end
    else
      render :new
    end
  end

  def show
    @compensation = current_user.compensations.find(params[:id])
    respond_to do |format|
      format.js { render :show, layout: false }
    end
  end

  def edit
    @compensation = current_user.compensations.find(params[:id])
    respond_to do |format|
      format.js { render :edit, layout: false }
    end
  end

  def update
    @compensation = current_user.compensations.find(params[:id])
    if @compensation.update_attributes(compensation_params)
      respond_to do |format|
        format.js { render :show, layout: false }
      end
    else
      render :edit
    end
  end

  def destroy
    @compensation = current_user.compensations.find(params[:id])
    @id = @compensation.id
    @compensation.destroy
    respond_to do |format|
      format.js { render :destroy, layout: false }
    end
  end

  def charts
    @charts = current_user.compensations.order(:start_date).chart_data
  end

  def compare
    if params[:term].present?
      @data = MedianSalary.find_titles(params[:term])
    elsif params[:search].present?
      @data = MedianSalary.search(params[:search])
    end 
    respond_to do |format|
      format.html
      format.js { render :compare, layout: false }
      format.json { render json: @data }
    end
  end

  private
  def compensation_params
    params.require(:compensation).permit(:currency, :title, :rate_type, :rate, :notes, :equity, :total, :base_salary, :bonus, :position_id, :position_type, :company, :location, :start_date, :end_date, :target, :actual_paid, :percent_of_target, :annual_equivalent, :number)
  end
end
