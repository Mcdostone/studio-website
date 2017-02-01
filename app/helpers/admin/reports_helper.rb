module Admin::ReportsHelper

	def format_message(report)
		report.message.length > 6 ? report.message[0...6] + '...' : report.message
	end
end