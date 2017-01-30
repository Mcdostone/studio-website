class Admin::UploadsController < AdminController
  before_action :set_admin_upload, only: [:destroy, :show]

  def index
    @uploads = Upload.includes(:type, :event).all
  end

  def new
    @events = Event.all
    @types = Type.all
    @upload = Upload.new
  end
  
  def create
    upload_params = admin_upload_params
    type = Type.find(upload_params[:type_id])
    event = Event.find(upload_params[:event_id])
    @upload = Upload.new(type: type, event: event, user: @current_user)
    @upload.save
    ActionCable.server.broadcast 'uploadProgress', {task: 's3'}
    
    upload_params[:media].each do |m|
      if @upload.media.create(type: type, event: event, file: m, upload: @Upload)
        ActionCable.server.broadcast 'uploadProgress', {task: 'upload'}
      end
    end
    
    ActionCable.server.broadcast 'uploadProgress', {task: 'end'}    
    respond_to do |format|
      msg = {:status => 200, :nbUploaded => upload_params[:media].size}
      format.json { render :json => msg }
    end
  end

  def show
  end

  private
    
    def set_admin_upload
      @upload = Upload.find(params[:id])
    end

    def admin_upload_params      
      params.require(:admin_upload).tap do |whitelisted|
        whitelisted[:event_id] = params[:admin_upload][:event_id]
        whitelisted[:type_id] = params[:admin_upload][:type_id]
        whitelisted[:media] = params[:admin_upload][:media].values
      end
    end
end
