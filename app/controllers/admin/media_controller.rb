class Admin::MediaController < AdminController

	before_action :set_medium, only:[:edit, :update, :destroy, :untag, :untag_all]

	def index
		@media = Medium.includes(:type, :album).all
	end

	def edit
		@types = Type.all
		@albums = Album.all
	end

	def update
		@medium.update(medium_params)
		redirect_to admin_media_path
	end

	def destroy
		@medium.destroy
		redirect_to admin_media_path
	end

	def untag
		@tag = ActsAsTaggableOn::Tag.find(params[:id_tag])
		@medium.tag_list.remove(@tag.name)
		@medium.save
		end

	def untag_all
		@medium.tags.delete_all
		redirect_to edit_admin_medium_path(@medium)
	end

	private
	def media_params
    	params.require(:media)
  	end

  	def medium_params
  		params.require(:medium).permit(:type_id, :album_id, :visible)
  	end

	def set_medium
		@medium = Medium.find(params[:id])
	end
end
