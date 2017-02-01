class Admin::ReportsController < AdminController

	before_action :set_report, only:[:show, :destroy]

	def index
		@reports = Report.all
	end

	def show
	end
	
	def destroy
		@medium.destroy
		redirect_to admin_media_path
	end

	private
	
	def set_report
		@report = Report.find(params[:id])
	end
end