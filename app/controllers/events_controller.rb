class EventsController < ApplicationController

  def index
	@events = Event.includes(:media).all
	respond_to do |format|
	  format.html
	  format.json { render :json => @events }
	end
  end

end
