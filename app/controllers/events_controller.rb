class EventsController < ApplicationController

  before_action :set_event, only:[:show]

  def index
	@events = Event.includes(:media).all
  end

  def show
  	@media = @event.media
  end

  private
	def set_event
		@event = Event.find(params[:id])
	end

end
