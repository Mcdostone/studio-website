class ActivitiesController < ApplicationController

	def index
 		@activities = PublicActivity::Activity.order(created_at: :asc).all
 		puts @activities.inspect
	end
  
end