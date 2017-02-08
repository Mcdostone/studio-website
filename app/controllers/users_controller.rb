class UsersController < ApplicationController
	layout 'application'

	before_action :set_user, only:[:show, :edit, :update]

	def index
		@users = User.all
	end

	def show
	end

	def edit
		redirect_to users_path unless @current_user == @user
		render :layout => 'admin'
	end

	def update
		@user.update(user_params) if(@current_user == @user)
		redirect_to user_path(@user)
	end

	private
	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:nickname, :avatar)
	end
end
