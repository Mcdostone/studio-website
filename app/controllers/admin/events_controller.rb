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
    if @event.save
      flash[:success] = "L'évent a été crée !"
      redirect_to admin_events_path
    else
      render :new
    end
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
		params.require(:event).permit(:name, :date, :cover)
	end

  def set_event
    @event = Event.find(params[:id])
  end

end
