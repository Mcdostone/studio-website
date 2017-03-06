class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_countdown, :current_user, :authenticate_user
  layout 'application'

  def current_user
  	begin
  		#@current_user = User.first
  		@current_user = User.find(session[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      nil
    end
  end


  def check_countdown
    d_day = DateTime.new(2017, 3, 20, 12, 0, 0, '+1')
#    if DateTime.now < d_day
#      redirect_to soon_path
#      return
#    end
  end


  def authenticate_user
    user = @current_user

    if user == nil
      redirect_to login_path
      return
    end
    if user.ban
      redirect_to logout_path
    end
  end

end
