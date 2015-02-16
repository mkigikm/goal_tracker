class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(session_token: session[:token])
  end

  def logged_in?
    !!current_user
  end

  def require_logged_out
    redirect_to goals_url if logged_in?
  end

  def require_logged_in
    redirect_to goals_url unless logged_in?
  end

  private
  def log_in!(user)
    session[:token] = user[:session_token]
  end

  def log_out!(user)
    session[:token] = nil
    user.reset_session_token!
  end
end
