class EventsController < ApplicationController

  before_action :set_event, only:[:show]

  def index
    #@events = Event.includes(:media).where(media: { visible: true })
    @events = Event.all

    respond_to do |format|
      format.html
      format.json { render :json => @events.to_json }
    end
  end

  def show
  	@media = @event.media
  end

  private
	def set_event
		@event = Event.find(params[:id])
	end

end
