module UsersHelper

	SIZE_NAVBAR = 100
	
	def url_picture_profile(user, size = SIZE_NAVBAR)
		user.picture ? "#{user.picture}?sz=#{size}" : 'default-profile-picture.png'
	end
end
