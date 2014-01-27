class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  
  before_filter :load_current_user
  before_filter :authentication_needed
  
  private
  def load_current_user
    if session[:current_user_id]
      @current_user = User.find(session[:current_user_id])
    end
  end
  
  def authentication_needed
    redirect_to new_session_path unless @current_user
  end
end
