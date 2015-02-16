class GoalsController < ApplicationController
  before_action :require_logged_in
  before_action :require_goal_owner, only: [:edit, :update]
  before_action :require_goal_owner_or_public, only: [:show]

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
    find_goal
    render :show
  end

  def edit
    find_goal
    render :edit
  end

  def update
    find_goal

    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      render :edit
    end
  end

  def destroy
    find_goal.destroy!

    redirect_to goals_url
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :public, :due_by, :description,
      :progress, :completed_on)
  end

  def find_goal
    @goal ||= Goal.find(params[:id])
  end

  def require_goal_owner
    redirect_to goals_url unless find_goal.user == current_user
  end

  def require_goal_owner_or_public
    unless find_goal.public || find_goal.user == current_user
      redirect_to goals_url
    end
  end
end
