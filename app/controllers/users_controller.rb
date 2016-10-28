class UsersController < ApplicationController
	layout 'application'

	before_action :set_user, only:[:show, :edit, :update]

	def index
		puts User.all.inspect
		@users = User.all
	end

	def show
	end

	def edit
	end

	def update
		@user.update(user_params)
		redirect_to users_path
	end
	
	private
		def user_params
			params.require(:user).permit(:nickname)		
		end

		def set_user
			@user = User.find(params[:id])
		end
end
