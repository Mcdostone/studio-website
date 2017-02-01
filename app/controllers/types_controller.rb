class TypesController < ApplicationController

	before_action :set_type, only:[:show]

	def index
		@types = Event.includes(:media).where(media: { visible: true })

		respond_to do |format|
      		format.html
      		format.json { render :json => @types.to_json }
    end
	end

	def show
		@media = @type.media
	end

	private
	def set_type
		@type = Type.find(params[:id])
	end
end
