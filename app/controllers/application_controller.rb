class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # Note: the following line ensures the following methods are available
  #   to our views. By default, methods defined here are available only to 
  #   other controllers
  helper_method :current_user, :logged_in?
  
  def current_user
    @current_user  ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    # Note: In the following line, !! converts result to boolean
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
  
end
