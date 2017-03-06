class Api::MediaController < ApiController

	before_action :set_medium, only:[:show, :like, :tag]

	def index
		@media = Medium.where(:visible => true).page(page_params[:page])
	end

	def show
	end

	def like
		@medium.liked_by @current_user
		@medium.unliked_by @current_user unless @medium.vote_registered?
	end

	def tag
		@medium.tag_list.add(tag_params[:name])
		@medium.save
	end

	private
	def set_medium
		@medium = Medium.find(params[:id])
	end

	def tag_params
		params.require(:tag).permit(:name)
	end

	def page_params
		params.permit(:page)
	end

end
