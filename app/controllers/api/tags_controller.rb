class Api::TagsController < ApiController

	before_action :set_tag, only:[:show]

	def show
		@media = Medium.tagged_with(@tag).page(page_params[:page])
		@media = @media.select {|medium| medium.visible == true}
		render 'api/media/index'
	end

	private
	def set_tag
		@tag = ActsAsTaggableOn::Tag.find(params[:id])
	end

	def page_params
		params.permit(:page)
	end

end
