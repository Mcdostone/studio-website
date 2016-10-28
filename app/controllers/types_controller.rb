class TypesController < ApplicationController
	layout 'application'

	before_action :set_type, only:[:edit, :update, :show, :destroy]

	def index
		@types = Type.all
	end

	def new
		@type = Type.new
	end

	def create
		@type = Type.new(type_params)
		@type.save
		if @type.save
			redirect_to types_path
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		@type.update(type_params)
		redirect_to types_path
	end

	def destroy
		@type.destroy
		redirect_to types_path
	end

	private
		def type_params
			params.require(:type).permit(:name)
		end

		def set_type
			@type = Type.find(params[:id])
		end
end
