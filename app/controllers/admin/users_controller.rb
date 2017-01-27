class Admin::UsersController < AdminController
	layout 'application'

	before_action :set_user, only:[:edit, :update, :ninja]

	def index
		@users = User.all
	end

	def edit
		if current_user.author? && !@user.admin? || @user == current_user || current_user.admin?
			@authorization = Authorization.find_by(name: 'author')
		else
			redirect_to admin_path
		end
	end

	def update
		if current_user.author? && !@user.viewer? || current_user.admin? && !@user.admin? 
			@user.update(user_params)
		end
		redirect_to admin_users_path	
	end

	def ninja
		if current_user.admin?
			#puts @user.inspect
			session[:user_id] = @user.id
			redirect_to root_path
		else
			redirect_to admin_path
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
