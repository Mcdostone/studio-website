module MediaHelper
	
	SIZE_THUMBNAIL = 300

	def thumbnail_url(media, access_token, size = SIZE_THUMBNAIL)
		"https://drive.google.com/thumbnail?access_token=#{access_token}&sz=w#{size}&id=#{media.id_file}"
	end
end
