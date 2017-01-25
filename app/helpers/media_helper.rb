module MediaHelper

	SIZE_THUMBNAIL = 100
	SIZE_MEDIA = 500

	def url_media(medium, access_token)
		medium.thumbnail_url
		#{}"https://drive.google.com/thumbnail?access_token=#{access_token}&sz=w#{SIZE_MEDIA}&id=#{media.id_file}"
	end


	def url_thumbnail(medium, access_token, size = SIZE_THUMBNAIL)
		#return "https://drive.google.com/uc?id=#{medium.id_file}"
		#return medium.thumbnail_url
		return medium ? "https://drive.google.com/thumbnail?access_token=#{access_token}&sz=w#{size}&id=#{media.id_file}" : '/images/film-projector.jpg'
	end
end
