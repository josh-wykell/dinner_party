class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  
  protected
  
  def current_user
    @current_user ||= User.where(id: session[:user_id]).first
  end

  def authenticate_user!
    redirect_to root_path unless current_user
  end
end
