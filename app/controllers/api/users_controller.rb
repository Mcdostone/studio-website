class Api::UsersController < ApiController

	before_action :set_user, only:[:show]

	def show
		@media = Kaminari.paginate_array(@user.find_voted_items).page(params[:page])
		@media = @media.select {|medium| medium.visible == true}
		render 'api/media/index'
	end

	private
	def set_user
		@user = User.find(params[:id])
	end

	def page_params
		params.permit(:page)
	end
end
