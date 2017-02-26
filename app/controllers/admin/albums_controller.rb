class Admin::AlbumsController < AdminController

    before_action :set_album, only:[:edit, :update, :destroy]

    def index
      @albums = Album.all
    end

    def new
      @album = Album.new
    end

    def create
    	@album = Album.new(album_params)
      if @album.save
        flash[:success] = "L'évent a été crée !"
        redirect_to admin_albums_path
      else
        render :new
      end
    end

    def edit
    end

    def update
      @album.update(album_params)
      redirect_to admin_albums_path
    end

    def destroy
      @album.destroy
      redirect_to admin_albums_path
    end

    private
    def album_params
  		params.require(:album).permit(:name, :date, :cover)
  	end

    def set_album
      @album = Album.find(params[:id])
    end
end
