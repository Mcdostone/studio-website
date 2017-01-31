class MediaController < ApplicationController
	
	before_action :set_medium, only:[:show, :like]

	def index
		@media = Medium.includes(:type, :event).all
	end

	def show
	end

	def like
		created = true
		if Like.exists?(medium: @medium, user: @current_user)
			Like.where(medium: @medium).where(user: @current_user).first.destroy
			flash[:success] = "You don't like ?"
			created = false
		else
			Like.create(medium: @medium, user: @current_user)
			flash[:success] = "Like counted !"
		end

 		respond_to do |format|      	
			format.json { render json: created}
		end
	end

	private
	def set_medium
		@medium = Medium.find(params[:id])
	end
end