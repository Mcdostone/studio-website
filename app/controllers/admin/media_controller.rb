class Admin::MediaController < AdminController

	before_action :set_medium, only:[:edit, :update, :destroy, :untag]

	def index
		@media = Medium.includes(:type, :event).all
	end

	def edit
		@types = Type.all
		@events = Event.all
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

	private
	def media_params
    	params.require(:media)
  	end

  	def medium_params
  		params.require(:medium).permit(:type_id, :event_id, :visible)
  	end

	def set_medium
		@medium = Medium.find(params[:id])
	end
end
