class MediaController < ApplicationController
	layout "application"

	def index 
		@media = Medium.all
	end
	
	def test
		@media = Medium.all
	end

	def edit
		@medium = Medium.find(params[:id])
	end

	def create
		media = JSON.parse(media_params.to_json)
		media.each do |m|
			@medium = Medium.new(id_file: m['id'])
			@medium.save
		end
		
		respond_to do |format|
			format.json { render :json => "ok", :status => 200 }
		end
	end

	def show
		@medium = Medium.find(params[:id])
	end

	def destroy
		@medium = Medium.find(params[:id])
		@medium.destroy

		redirect_to media_path
	end

	def picker
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
		redirect_to root_path unless @current_user
	end

	private
		def media_params
    		params.require(:media)
  		end
end