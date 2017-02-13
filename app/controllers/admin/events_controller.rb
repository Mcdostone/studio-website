class Admin::EventsController < AdminController

  before_action :set_event, only:[:edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
  	@event = Event.new(event_params)
  	flash[:success] = "L'événement a été crée !" if @event.save
    redirect_to admin_events_path
  end

  def edit
  end

  def update
    @event.update(event_params)
    redirect_to admin_events_path
  end

  def destroy
    @event.destroy
    redirect_to admin_events_path
  end

  private
  def event_params
		params.require(:event).permit(:name, :date_event, :cover)
	end

  def set_event
    @event = Event.find(params[:id])
  end

end