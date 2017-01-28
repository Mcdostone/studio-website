module MediaHelper

	SIZE_THUMBNAIL = 100
	SIZE_MEDIA = 500

	def url_media medium
		medium.file.url
	end


	def url_thumbnail medium
		medium ? medium.file.url : '/images/film-projector.jpg'
	end
end
