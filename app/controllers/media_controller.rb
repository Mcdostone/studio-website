class MediaController < ApplicationController
	
	before_action :set_medium, only:[:show, :like]

	def index
		@media = Medium.includes(:type, :event).all
	end

	def show
		respond_to do |format|
			format.json { render json: @medium}
		end
	end

	def like
		exists = Like.exists?(medium: @medium, user: @current_user)
		
		if exists
			Like.where(medium: @medium, user: @current_user).first.destroy
			flash[:success] = "You don't like ?"
		else
			Like.create(medium: @medium, user: @current_user)
			flash[:success] = "Like counted !"
		end

 		respond_to do |format|
			format.json { render json: exists}
		end
	end

	private
	def set_medium
		@medium = Medium.find(params[:id])
	end
end