class TypesController < ApplicationController
	layout 'application'

	before_action :set_type, only:[:show]

	def index
		@types = Type.includes(:media).all
		respond_to do |format|
			format.html
			format.json { render :json => @types }
		end
	end

	def show
	end

	private
	def set_type
		@type = Type.find(params[:id])
	end
end
