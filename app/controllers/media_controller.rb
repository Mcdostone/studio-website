class MediaController < ApplicationController
	layout "application"

	before_action :set_medium, only:[:show]

	def index
		@media = Medium.includes(:type, :event).all
	end

	def show
	end

	private
	def set_medium
		@medium = Medium.find(params[:id])
	end
end