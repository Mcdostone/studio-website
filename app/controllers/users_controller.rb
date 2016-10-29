class UsersController < ApplicationController
	layout 'application'
	
	before_action :set_user, only:[:show, :edit, :update]

	def index
		@users = User.all
	end

	def show
		puts @user.inspect
		puts "render madafucka"
	end

	private
	def set_user
		@user = User.find(params[:id])
	end
end
