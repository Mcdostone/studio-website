class Admin::TagsController < AdminController

	before_action :set_tag, only:[:edit, :destroy]

	def index
		@tags = ActsAsTaggableOn::Tag.all
	end

	def destroy
		@tag.destroy
	end

	private
	def set_tag
		@tag = ActsAsTaggableOn::Tag.find(params[:id])
	end

end
