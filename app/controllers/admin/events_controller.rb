class Admin::EventsController < AdminController

	def new
		@event = Event.new
	end

  def index
    @events = Event.all
    puts @events.inspect
  end

  def create
  	@event = Event.new(event_params)
  	@event.save
  	redirect_to admin_events_path
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    redirect_to admin_events_path
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_to admin_events_path
  end

  private
  def event_params
		params.require(:event).permit(:name, :date_event)
	end

end