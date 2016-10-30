class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  
  def current_user
  	begin
  		@current_user ||= User.find(session[:user_id]) if session[:user_id]
  	rescue ActiveRecord::RecordNotFound => e
    		redirect_to signout_path
        return
    end
  end

end