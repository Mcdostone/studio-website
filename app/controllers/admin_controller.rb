class AdminController < ApplicationController
 	include PublicActivity::StoreController
	before_action :require_author
	layout 'admin'
	def index
		@media_count =  Medium.count
		@events_count =  Event.count
		@types_count =  Type.count
		@uploads_count =  Upload.count
		@reports_count =  Report.count
		@users = User.includes(:authorization).all
	end

  	def require_author
		if(@current_user.author? || @current_user.admin?)
			true
		else
			redirect_to root_path
			return
		end
	end

end
