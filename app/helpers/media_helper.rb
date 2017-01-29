module MediaHelper

	def url_media medium
		medium.file.url
	end

	def url_thumbnail medium
		medium ? medium.file.url(:thumb) : '/images/film-projector.jpg'
	end
end
