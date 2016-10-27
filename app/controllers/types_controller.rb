class TypesController < ApplicationController
	layout 'application'

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
		@type = Type.find(params[:id])
	end

	def update
		@type = Type.find(params[:id])
		@type.update(type_params)
		redirect_to types_path
	end

	def destroy
		@type = Type.find(params[:id])
		@type.destroy
		redirect_to types_path
	end

	private
		def type_params
			params.require(:type).permit(:name)
		end
end
