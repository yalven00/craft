class GoalsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @goals = current_user.goals
    @desired_jobs = current_user.desired_jobs
  end

  def new
    @goal = Goal.new
  end

  def create
    manage_date
    @goal = current_user.goals.build(goal_params)
    if @goal.save
      redirect_to goals_url
    else
      render :action => 'new'
    end
  end

  def edit
    @goal = current_user.goals.find(params[:id])
  end

  def update
    manage_date
    @goal = current_user.goals.find(params[:id])
    if @goal.update_attributes(goal_params)
      redirect_to goals_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @goal = current_user.goals.find(params[:id])
    @goal.destroy
    redirect_to goals_url
  end

private
  def manage_date
    (1..3).each{|i| params[:goal]["date(#{i}i)"] = ''} if params[:no_date] === '1'
  end

  def goal_params
    params.require(:goal).permit(:description, :date, :title)
  end

end
