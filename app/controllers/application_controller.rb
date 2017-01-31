class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #helper_method :current_user
  before_action :current_user, :authenticate_user
  
  def current_user
  	begin
  		@current_user = User.find(session[:user_id])
    rescue ActiveRecord::RecordNotFound => e
  	end
  end

  def authenticate_user
    user = current_user
    redirect_to root_path unless user
    redirect_to logout_path if user.ban
    redirect_to root_path unless user
  end

end