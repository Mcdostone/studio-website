class Admin::ReportsController < AdminController

	before_action :set_report, only:[:show, :destroy, :valid]

	def index
		@reports = Report.all
	end

	def show
	end
	
	def valid
		@report.medium.destroy
		@report.destroy
		redirect_to admin_reports_path
	end

	def destroy
		@report.medium.update(visible: true)
		@report.destroy
		redirect_to admin_reports_path
	end

	private
	
	def set_report
		@report = Report.find(params[:id])
	end
end