class Api::TypesController < ApiController

	before_action :set_type, only:[:show]

	def show
		@media = Medium.where(:visible => true, :type_id => @type.id).page(page_params[:page])
		@media = @media.select {|medium| medium.visible == true}
		render 'api/media/index'
	end

	private
	def set_type
		@type = Type.find(params[:id])
	end

	def page_params
		params.permit(:page)
	end
end
