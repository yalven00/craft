class PositionsController < InheritedResources::Base
  before_filter :authenticate_user!

  def index
    @current_positions = current_user.positions.current.order('start_date ASC')
    @past_positions = current_user.positions.past.order('start_date ASC')
  end

  def new
    @position = current_user.positions.build
  end

  def create
    @position = current_user.positions.build(position_params)
    if @position.save
      location = @position.full_time? ? new_project_path(position_id: @position.id) : positions_path
      redirect_to location
    else
      render :new
    end
  end

  def edit
    @position = current_user.positions.find(params[:id])
  end

  def update
    @position = current_user.positions.find(params[:id])
    if @position.update_attributes(position_params)
      redirect_to positions_path
    else
      render :edit
    end
  end

  def destroy
    @position = current_user.positions.find(params[:id])
    @position.destroy
    redirect_to positions_path
  end

  def end
    @position = current_user.positions.find(params[:id])
    @position.end!
    redirect_to positions_path
  end

  private
  def position_params
    params.require(:position).permit(:company, :title, :location, :position_type, :start_date, :end_date)
  end
end
