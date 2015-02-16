class UsersController < ApplicationController
  before_action :require_logged_out, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in!(@user)
      redirect_to goals_url
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :password)
  end
end
