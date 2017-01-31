class MediaController < ApplicationController
	
	before_action :set_medium, only:[:show, :like]

	def index
		@media = Medium.includes(:type, :event).all
	end

	def show
	end

	def like
		like = Like.new
		if Like.exists?(medium: @medium, user: current_user)
			Like.where(medium: @medium).where(user: current_user).first.destroy
			flash[:success] = "You don't like ?"
		else
			Like.create(medium: @medium, user: current_user)
			flash[:success] = "Like counted !"
		end
		redirect_to :back
	end

	private
	def set_medium
		@medium = Medium.find(params[:id])
	end
end