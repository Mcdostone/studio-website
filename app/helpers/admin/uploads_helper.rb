module Admin::UploadsHelper

	def format_upload_date(date)
		date.strftime('%d/%m/%Y')
	end
end
