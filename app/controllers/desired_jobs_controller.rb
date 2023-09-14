class DesiredJobsController < ApplicationController
  before_filter :authenticate_user!
  def new
    @desired_job = current_user.desired_jobs.build
  end

  def create
    @desired_job = current_user.desired_jobs.build(desired_job_params)
    if @desired_job.save
      redirect_to goals_path
    else
      render :new
    end
  end
  
  def edit
    @desired_job = current_user.desired_jobs.find(params[:id])
  end

  def update
    @desired_job = current_user.desired_jobs.find(params[:id])
    if @desired_job.update_attributes(desired_job_params)
      redirect_to goals_path
    else
      render :edit
    end
  end

  def destroy
    @id = params[:id]
    desired_job = current_user.desired_jobs.find(@id)
    desired_job.destroy
    respond_to do |format|
      format.js { render :destroy, layout: false}
    end
  end

private
  def desired_job_params
    params.require(:desired_job).permit(:company, :title, :location, :link, :description, :industry)
  end
end
