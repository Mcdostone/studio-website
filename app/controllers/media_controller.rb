class MediaController < ApplicationController
	
	before_action :set_medium, only:[:show, :like]

	def index
		@media = Medium.includes(:type, :event).all
	end

	def show
	end

	def like
		puts "hello !"
		Like.create(medium: @medium, user: current_user)
		flash[:success] = "Like Counted!"
		redirect_to :back
	end

	private
	def set_medium
		@medium = Medium.find(params[:id])
	end
end