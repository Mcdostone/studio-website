class TypesController < ApplicationController

	before_action :set_type, only:[:show]

	def index
		@types = Type.all
		respond_to do |format|
			format.html
      format.json { render :json => @types.to_json }
    end
	end

	def show
	end

	private
	def set_type
		@type = Type.find(params[:id])
		@filtered_media = @type.media.select{|m| m.visible == true}
	end
end
