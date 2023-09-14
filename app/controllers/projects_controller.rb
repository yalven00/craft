class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  def new
    @position = current_user.positions.find(params[:position_id])
    @project = @position.projects.build()
    respond_to do |format|
      format.js { render :new, layout: false }
    end
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      # redirect_to where_to_redirect
      respond_to do |format|
        format.js { render :create, layout: false }
      end
    else
      render :new
    end
  end

  def edit
    @asset = Asset.new
    @project = current_user.projects.find(params[:id])
    @position = @project.position
    respond_to do |format|
      format.html
      format.js { render :edit, layout: false }
    end
  end

  def update
    @project = current_user.projects.find(params[:id])
    if @project.update_attributes(project_params)
      respond_to do |format|
        format.html { redirect_to where_to_redirect }
        format.js { render :update, layout: false, project: @project }
      end
    else
      render :edit
    end
  end

  def show
    @project = current_user.projects.find(params[:id])
    respond_to do |format|
      format.html { redirect_to where_to_redirect }
      format.js { render :show, layout: false, project: @project }
    end
  end

  def destroy
    @project = current_user.projects.find(params[:id])
    @project.destroy
    respond_to do |format|
      format.js { render :destroy, layout: false }
    end
    # redirect_to where_to_redirect
  end

  def complete
    @project = current_user.projects.find(params[:id])
    @project.complete!
    redirect_to current_positions_path
  end

  private
  def where_to_redirect
    @project.position.current? ? current_positions_path : past_positions_path
  end

  def project_params
    params.require(:project).permit(:name, :status, :next_steps, :percent_of_time, :position_id, :end_date, :start_date, :description, :link, :manager_comment, :completed,
      assets_attributes: [:description, :file, :id, :_destroy])
  end
end
