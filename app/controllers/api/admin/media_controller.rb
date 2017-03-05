class Api::Admin::MediaController < ApiController

	def index
		@media = Medium.page(page_params[:page])
	end

	private
	def page_params
		params.permit(:page)
	end

end
