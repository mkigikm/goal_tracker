class SessionsController < ApplicationController
  before_action :require_logged_out, only: [:new, :create]

  def destroy
    log_out!(current_user)
    redirect_to new_session_url
  end

  def new
    @user = User.new
    @password_error = []
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:name],
      params[:user][:password]);

    if @user
      log_in!(@user)
      redirect_to goals_url
    else
      @user = User.new(name: params[:user][:name])
      @password_error = ["Incorrect Password"]
      render :new
    end
  end
end
