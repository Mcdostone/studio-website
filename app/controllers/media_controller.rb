class MediaController < ApplicationController

	before_action :set_medium, only:[:show, :like, :tag]
	skip_before_action :verify_authenticity_token

	def index
		@media = Medium.includes(:type, :event).all
	end

	def show
		if @medium.visible
			liked = @current_user.liked?(@medium)
			render json: { :medium => @medium.as_json(:include => :tags, :methods => :count_likes), :liked => liked}.to_json
		else
			render json: nil
		end
	end

	def like
		@medium.liked_by @current_user
		@medium.unliked_by @current_user unless @medium.vote_registered?
		render json: {:liked => @medium.vote_registered?, :count_likes => @medium.count_likes}.to_json
	end

	def tag
		@medium.tag_list.add(tag_params[:name])
		@medium.save
		render json: @medium.to_json(include: :tags)
	end

	private
	def set_medium
		@medium = Medium.find(params[:id])
	end

	def tag_params
		params.require(:tag).permit(:name)
	end
end
