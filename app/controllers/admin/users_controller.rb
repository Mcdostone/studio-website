class Admin::UsersController < AdminController

	before_action :set_user, only:[:edit, :update, :ninja]
	before_action :is_authorized, only:[:edit, :update]

	def index
		@users = User.all
	end

	def edit
		@authorization = Authorization.find_by(name: 'author')
	end

	def update
		@user.update(user_params)
		redirect_to admin_users_path
	end

	def ninja
		if @current_user.admin? && @current_user != @user
			session[:user_id] = @user.id
			redirect_to root_path
		else
			redirect_to admin_path
		end
	end

	private
	def user_params
		user_p = params.require(:user).permit(:nickname, :authorization, :ban, :avatar)
		if(!@user.admin? && @current_user.admin?)
			user_p[:authorization] = Authorization.find_by(name: (user_p[:authorization] == '1' ? 'author' : 'viewer'))
		else
			user_p[:authorization] = @user.authorization
		end
		user_p
	end

	def set_user
		@user = User.find(params[:id])
	end

	def is_authorized
		unless !(@current_user.author? && @user.admin?) || @current_user.admin?
			flash[:warning] = "Tu t'es cru où gamin ?"
			redirect_to admin_users_path
		end
	end

end
