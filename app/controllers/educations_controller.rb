class EducationsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @educations = current_user.educations.order('start_year DESC')
  end

  def show
    @education = Education.find(params[:id])
  end

  def new
    @education = Education.new
  end

  def create
    @education = current_user.educations.build(education_params)
    if @education.save
      current_user.assets.where(mid: nil, for_model: 'education').each{|a| a.mid = @education.id; a.save}
      respond_to do |format|
        format.html { redirect_to '/education' }
        format.js { render :create, layout: false }
      end
    else
      render :action => 'new'
    end
  end

  def edit
    @education = Education.find(params[:id])
  end

  def update
    @education = Education.find(params[:id])
    if @education.update_attributes(education_params)
      respond_to do |format|
        format.html { redirect_to '/education' }
        format.js { render :create, layout: false }
      end
    else
      render :action => 'edit'
    end
  end

  def destroy
    @education = Education.find(params[:id])
    @education.destroy
    redirect_to '/education'
  end

  private
  def education_params
    params.require(:education).permit(:school, :start_year, :end_year, :degree, :field_of_study, :grade, :activities, :notes,
      terms_attributes: [:id, :semester, :year, :_destroy, 
        grades_attributes: [:id, :name, :number, :grade, :term_id, :_destroy]], 
        assets_attributes: [:id, :description, :file, :_destroy], 
        transcripts_attributes: [:id, :description, :file, :file_file_name])
  end
end
