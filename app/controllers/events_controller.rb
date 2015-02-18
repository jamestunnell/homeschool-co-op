class EventsController < ApplicationController
  before_action :set_coordinating
  before_action :set_event, only: [:show,:edit,:update,:destroy]

  def index
    @events = Event.order("start_time DESC")
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to events_path, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to events_path, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: 'Event was successfully destroyed.'
  end

  private
  def event_params
    params.require(:event).permit(:title,:description,:start_time,:end_time,:photo,:photo_cache,:building_id)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
