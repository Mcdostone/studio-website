class Admin::UsersController < AdminController
	layout 'application'

	before_action :set_user, only:[:show, :edit, :update]

	def index
		@users = User.all
	end

	def show
	end

	def edit
	end

	def update
		puts user_params.inspect
		@user.update(user_params)
		redirect_to admin_users_path
	end
	
	private
		def user_params
			params.require(:user).permit(:nickname, :admin)
		end

		def set_user
			@user = User.find(params[:id])
		end
end
