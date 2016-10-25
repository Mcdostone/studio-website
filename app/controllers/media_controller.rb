class MediaController < ApplicationController
	layout "application"
	protect_from_forgery with: :null_session

	def index
		@medias = Medium.all
	end

	def create
		medias = JSON.parse(medias_params_json.to_json)
		medias.each do |m|
			@medium = Medium.new(id_file: m['id'])
			@medium.save
		end
		
		respond_to do |format|
			format.json { render :json => "ok", :status => 200 }
		end
	end

	def picker
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
		redirect_to root_path unless @current_user
	end

	private
		def medias_params_json
    		params.require(:medias)
  		end
end