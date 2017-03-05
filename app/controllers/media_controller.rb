class MediaController < ApplicationController

	def index
		@media_count = Medium.count
		puts @media_count
	end

end
