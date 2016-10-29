class Admin::UsersController < AdminController
	layout 'application'

	before_action :set_user, only:[:show, :edit, :update]

	def index
		@users = User.all
	end

	def edit
		@authorization = Authorization.find_by(name: 'author')
	end

	def update
		@user.update(user_params)
		if(current_user.author?)
			redirect_to admin_users_path
		else
			redirect_to root_path
		end
	end
	
	private
	def user_params
		user_p = params.require(:user).permit(:nickname, :authorization)
		if(!@user.admin? && current_user.admin?)
			user_p[:authorization] = Authorization.find_by(name: (user_p[:authorization] == '1' ? 'author' : 'viewer'))
		else 
			user_p[:authorization] = @user.authorization
		end
		user_p
	end

	def set_user
		@user = User.find(params[:id])
	end
	
end