class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :authenticate_user
  
  def current_user
  	begin
  		@current_user = User.find(session[:user_id])
    rescue ActiveRecord::RecordNotFound => e
  	end
  end

  def authenticate_user
    redirect_to root_path unless current_user
    redirect_to logout_path if current_user.ban
    redirect_to root_path unless current_user
  end

end