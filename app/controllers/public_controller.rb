class PublicController < ApplicationController
	skip_before_action :authenticate_user
	skip_before_action :check_countdown, :only => [:soon]
	layout 'public'

	def index
	end

	def not_found
	end

	def hacker
	end

	def soon
		render layout: 'countdown'
	end
end
