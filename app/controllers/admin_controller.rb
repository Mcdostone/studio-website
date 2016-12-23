class AdminController < ApplicationController

	before_action :require_author

	def index
		@media_count =  Medium.count
		@events_count =  Event.count
		@types_count =  Type.count
	end

	def require_admin
		redirect_to root_path unless current_user.admin?
		return
  	end

  	def require_author
		if(current_user.author?)
			true
		else
			redirect_to root_path
			return
		end
	end
end