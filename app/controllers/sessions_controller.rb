class SessionsController < ApplicationController
	
	skip_before_action :authenticate_user
	
	def create
		user = User.from_omniauth(env["omniauth.auth"])
		if user
			if user.ban
				flash[:warning] = 'Tu as été banni <3'
				redirect_to root_path
			else
				session[:user_id] = user.id
				redirect_to root_path
			end
		else
			flash[:warning] = "Tu dois te connecter avec une adresse @TN.net"
			redirect_to root_path
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path
	end

end