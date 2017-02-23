class MediaController < ApplicationController

	before_action :set_medium, only:[:show, :like, :tag]
	skip_before_action :verify_authenticity_token

	def index
		@media = Medium.includes(:type, :event).all
	end

	def show
		if @medium.visible
			render json: @medium.to_json(include: :tags)
		else
			render json: nil
		end
	end

	def like
		exists = Like.exists?(medium: @medium, user: @current_user)

		if exists
			Like.where(medium: @medium, user: @current_user).first.destroy
			flash[:success] = "You don't like ?"
		else
			Like.create(medium: @medium, user: @current_user)
			flash[:success] = "Like counted !"
		end

 		respond_to do |format|
			format.json { render json: exists}
		end
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
end
