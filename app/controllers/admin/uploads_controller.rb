class Admin::UploadsController < ApplicationController
  before_action :set_admin_upload, only: [:destroy]
  layout 'upload'

  def index
    @events = Event.all
    @types = Type.all
    @upload = Admin::Upload.new
  end

  def create
    upload_params = admin_upload_params
    type = Type.find(upload_params[:type])
    event = Event.find(upload_params[:event])
    @upload = Admin::Upload.new(type: type, event: event)
    @upload.save

    upload_params[:media].each do |m|
      @upload.media.create(type: type, event: event, file: m)
    end
    
    respond_to do |format|
      msg = {:status => 200, :nbUploaded => upload_params[:media].size}
      format.json { render :json => msg }
    end
  end

  private
    
    def set_admin_upload
      @admin_upload = Admin::Upload.find(params[:id])
    end

    def admin_upload_params      
      params.require(:admin_upload).tap do |whitelisted|
        whitelisted[:event] = params[:admin_upload][:event]
        whitelisted[:type] = params[:admin_upload][:type]
        whitelisted[:media] = params[:admin_upload][:media].values
      end
    end
end
