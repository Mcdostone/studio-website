module MediaHelper

	SIZE_THUMBNAIL = 300
	SIZE_MEDIA = 500

	def url_media(media, access_token)
		"https://drive.google.com/thumbnail?access_token=#{access_token}&sz=w#{SIZE_MEDIA}&id=#{media.id_file}"
	end

	def url_thumbnail(media, access_token, size = SIZE_THUMBNAIL)
		return media ? "https://drive.google.com/thumbnail?access_token=#{access_token}&sz=w#{size}&id=#{media.id_file}" : '/images/film-projector.jpg'
	end
end
