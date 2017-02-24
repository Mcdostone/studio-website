class Admin::TagsController < AdminController

	before_action :set_tag, only:[:edit, :destroy]

	def index
		tmp = ActsAsTaggableOn::Tag.all
		@tags = tmp.order(taggings_count: :desc)
	end

	def destroy
		@tag.destroy
		redirect_to admin_tags_path	
	end

	private
	def set_tag
		@tag = ActsAsTaggableOn::Tag.find(params[:id])
	end

end
