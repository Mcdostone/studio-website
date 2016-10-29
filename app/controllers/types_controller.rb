class TypesController < ApplicationController
	layout 'application'

	before_action :set_type, only:[:show]

	def index
		@types = Type.all
	end

	def show
	end

	private
	def set_type
		@type = Type.find(params[:id])
	end
end
