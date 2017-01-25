module UsersHelper

	SIZE_NAVBAR = 100

	def url_picture_profile(user, size = SIZE_NAVBAR)
		#user.picture ? "#{user.picture}?sz=#{size}" : 'default-profile-picture.png'
		'default-profile-picture.png'
	end

	def get_full_name(user)
		return "#{user.first_name} #{user.last_name}"
	end
end
