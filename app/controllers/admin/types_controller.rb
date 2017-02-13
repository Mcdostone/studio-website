class Admin::TypesController < AdminController

	before_action :set_type, only:[:edit, :update, :destroy]

	def index
		@types = Type.all
	end

	def new
		@type = Type.new
	end

	def create
		@type = Type.new(type_params)
  		flash[:success] = "Le type a été crée !" if @type.save
    	redirect_to admin_types_path
  	end

	def edit
	end

	def update
		@type.update(type_params)
		redirect_to admin_types_path
	end

	def destroy
		@type.destroy
		redirect_to admin_types_path
	end

	private
	def type_params
		params.require(:type).permit(:name, :mime_types, :cover)
	end

	def set_type
		@type = Type.find(params[:id])
	end
	
end