class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:show,:index]
  before_action :ensure_scheduler, only: [:new,:create,:edit,:update,:destroy]
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    @rooms = Room.all
  end
  
  def new
    @room = Building.find(params[:building_id]).rooms.build
  end

  def create
    @room = Room.new(room_params)

    if @room.save
      redirect_to building_path(@room.building), notice: 'Room was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to building_path(@room.building), notice: 'Room was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    building = @room.building
    @room.destroy
    redirect_to building_path(building), notice: 'Room was successfully destroyed.'
  end

  private
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def room_params
      params.require(:room).permit(:name, :building_id)
    end
end
