module UsersHelper

	SIZE_NAVBAR = 100

	def picture_profile user, thumb = false
		if user.nil? || user.avatar.url == nil
			'default-profile-picture.png'
		else
			thumb ? user.avatar.url(:thumb) : user.avatar.url
		end
	end

	def full_name(user)
		return "#{user.first_name} #{user.last_name}" if user
	end

	def profile_name(user)
		user.nickname.empty? ? user.first_name : user.nickname
	end
end
