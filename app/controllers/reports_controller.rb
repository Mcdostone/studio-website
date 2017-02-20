class ReportsController < ApplicationController

  before_action :set_medium, only:[:new, :create]
  layout 'admin'

  def new
    @report = Report.new
    redirect_to root_path unless @medium.visible  
  end

  def create
    @report = Report.new(report_params)
    @report.user = @current_user
    @report.medium = @medium
    if @report.save
      @medium.visible = false
      @medium.save
      flash[:notice] = 'Votre report a été enregistré'
      redirect_to media_path
    end
  end

  private
    def set_medium
      @medium = Medium.find(params[:id])
    end

    def report_params
      params.require(:report).permit(:message)
    end
end
