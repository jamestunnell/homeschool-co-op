class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_scheduler, only: [:new,:create,:edit,:update,:destroy]
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    @rooms = Room.all
  end
  
  def new
    @room = Room.new(building_id: params[:building_id])
  end

  def create
    @room = Room.new(room_params)

    if @room.save
      redirect_to responsibility_kind_path(:scheduling), notice: 'Room was successfully created.'
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
      redirect_to responsibility_kind_path(:scheduling), notice: 'Room was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    redirect_to responsibility_kind_path(:scheduling), notice: 'Room was successfully destroyed.'
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
