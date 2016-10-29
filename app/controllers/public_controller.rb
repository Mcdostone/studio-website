class PublicController < ApplicationController
	
  def index
    puts current_user.inspect
  end
  
end
