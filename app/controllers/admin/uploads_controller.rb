class Admin::UploadsController < AdminController
  before_action :set_admin_upload, only: [:show, :destroy]

  def index
    @uploads = Upload.includes(:type, :album).all
    @check = Album.count != 0 &&Type.count != 0
  end

  def new
    @albums = Album.all
    @types = Type.all
    @upload = Upload.new
    if(@albums.size == 0 || @types.size == 0)
      redirect_to admin_uploads_path
    end
  end

  def create
    @upload = Upload.new
    upload_params = admin_upload_params
    type = Type.find(upload_params[:type_id])
    album = Album.find(upload_params[:album_id])
    @upload = Upload.new(type: type, album: album, user: @current_user)
    if @upload.save
      ActionCable.server.broadcast 'uploadProgress', {task: 's3'}

      upload_params[:media].each do |m|
        if @upload.media.create(type: type, album: album, file: m, upload: @upload)
          ActionCable.server.broadcast 'uploadProgress', {task: 'upload'}
        end
      end

      ActionCable.server.broadcast 'uploadProgress', {task: 'end',
        url: Rails.application.routes.url_helpers.admin_upload_path(@upload)}
      respond_to do |format|
        msg = {:status => 200, :nbUploaded => upload_params[:media].size}
        format.json { render :json => msg }
      end
    end
  end

  def show
  end

  def video
    upload_params = admin_upload_video_params
    type = Type.find(upload_params[:type_id])
    album = Album.find(upload_params[:album_id])
    @upload = Upload.new(type: type, album: album, user: @current_user)

    @upload.media.create(type: type, album: album, file: m, upload: @upload)

    redirect_to admin_uploads_path
  end


  def destroy
  end

  private

    def set_admin_upload
      @upload = Upload.find(params[:id])
    end

    def admin_upload_params
      params.require(:admin_upload).tap do |whitelisted|
        whitelisted[:albumsid] = params[:admin_upload][:albumsid]
        whitelisted[:type_id] = params[:admin_upload][:type_id]
        whitelisted[:media] = params[:admin_upload][:media].values
      end
    end

    def admin_upload_video_params
      params.require(:admin_upload).permit(:albumsid, :type_id, :video)
    end
end
