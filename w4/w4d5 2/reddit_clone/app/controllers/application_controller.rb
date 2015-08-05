class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :require_login!
  helper_method :user_params

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def log_in!(user)
    session[:session_token] = user.reset_session_token!
  end

  def log_out!
    session[:session_token] = nil
    current_user.reset_session_token!
  end

  def require_login!
    redirect_to new_session_url unless current_user
  end

  def require_logout
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
