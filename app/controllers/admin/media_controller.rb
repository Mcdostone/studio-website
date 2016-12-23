class Admin::MediaController < AdminController
	layout "application"
	before_action :set_medium, only:[:edit, :update, :show, :destroy]

	def index
		@media = Medium.includes(:type, :event).all
	end

	def create
		puts "fkjsdjkfgdkjfgkjdfgkjdkjfg #{media}"
		media = JSON.parse(media_params)

		media.each do |m|
			@medium = Medium.new(id_file: m['id'])
			@medium.save
		end

		respond_to do |format|
			format.json { render :json => "ok", :status => 200 }
		end
	end

	def edit
		@types = Type.all
		@events = Event.all
	end

	def update
		@medium.update(medium_params)
		redirect_to admin_media_path
	end

	def show
	end

	def destroy
		@medium.destroy
		redirect_to admin_media_path
	end

	def picker
	end

	private
	def media_params
    	params.require(:media)
  	end

  	def medium_params
  		params.require(:medium).permit(:type_id, :event_id)
  	end

	def set_medium
		@medium = Medium.find(params[:id])
	end
end