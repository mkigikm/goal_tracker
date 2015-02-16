class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    @user.valid?
    render :new
  end

  private
  def user_params
    params.require(:user).permit(:name, :password)
  end
end
