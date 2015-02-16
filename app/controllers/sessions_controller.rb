class SessionsController < ApplicationController
  def destroy
    log_out!(current_user)
    redirect_to new_session_url
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:name],
      params[:user][:password]);

    if @user
      log_in!(@user)
      redirect_to goals_url
    else
      render :new
    end
  end
end
