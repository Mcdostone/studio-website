class Api::TagsController < ApiController

	before_action :set_tag, only:[:show]

	def show
		@media = Medium.tagged_with(@tag)
		render 'api/lightbox/index'
	end

	private
	def set_tag
		@tag = ActsAsTaggableOn::Tag.find(params[:id])
	end
end
