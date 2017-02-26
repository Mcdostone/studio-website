class AlbumsController < ApplicationController
  before_action :set_album, only:[:show]

  def index
    @albums = Album.all

    respond_to do |format|
      format.html
      format.json { render :json => @albums.to_json }
    end
  end

  def show
  end

  private
	def set_album
		@album = Album.find(params[:id])
    @filtered_media = @album.media.select{|m| m.visible == true}
	end
end
