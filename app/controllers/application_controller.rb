class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user, :authenticate_user
  layout 'application'

  def current_user
  	begin
  		@current_user = User.first
  		#@current_user = User.find(session[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      nil
    end
  end

  def authenticate_user
    user = @current_user

    if user == nil
      flash[:warning] = "connect"
      redirect_to root_path
      return
    end
    if user.ban
      redirect_to logout_path
    end
  end

end
