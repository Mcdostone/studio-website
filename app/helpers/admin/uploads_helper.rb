module Admin::UploadsHelper

	def format_upload_date(date)
		date.strftime('%d/%m/%Y')
	end

	def count_media(upload)
		return "#{upload.media.size}" + (upload.media.size > 1 ? ' médias' : ' média')
	end 
end
