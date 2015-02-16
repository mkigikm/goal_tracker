class GoalsController < ApplicationController
  before_action :require_logged_in

  def index
    render :index
  end

  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = current_user.goals.new(goal_params)

    if @goal.save
      redirect_to goals_url
    else
      render :new
    end
  end

  def show
    @goal = find_goal
    render :show
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :public, :due_by, :description,
      :progress)
  end

  def find_goal
    Goal.find(params[:id])
  end
end
