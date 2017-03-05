class Api::Admin::UploadsController < ApiController

	before_action :set_upload, only:[:show]

	def show
		@media = Medium.where(:upload_id => @upload.id).page(page_params[:page])
		render 'api/media/index'
	end

	private
	def set_upload
		@upload = Upload.find(params[:id])
	end

	def page_params
		params.permit(:page)
	end
end
