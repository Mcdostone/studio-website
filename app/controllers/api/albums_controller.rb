class Api::AlbumsController < ApiController

	before_action :set_album, only:[:show]

	def show
		@media = Medium.where(:visible => true, :album_id => @album.id).page(page_params[:page])
		@media = @media.select {|medium| medium.visible == true}
		render 'api/media/index'
	end

	private
	def set_album
		@album = Album.find(params[:id])
	end

	def page_params
		params.permit(:page)
	end
end
