class EventsController < ApplicationController

  before_action :set_event, only:[:show]

  def index
    @events = Event.all

    respond_to do |format|
      format.html
      format.json { render :json => @events.to_json }
    end
  end

  def show
  end

  private
	def set_event
		@event = Event.find(params[:id])
    @filtered_media = @event.media.select{|m| m.visible == true}
	end

end
