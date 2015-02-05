class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  # GET /buildings/:building_id/rooms/:id
  def show
  end

  # GET /buildings/:building_id/rooms/new
  def new
    @room = Room.new(building_id: params[:building_id])
  end

  # GET /buildings/:building_id/rooms/:id/edit
  def edit
  end

  # POST /buildings/:building_id/rooms
  def create
    @room = Room.new(room_params)

    if @room.save
      redirect_to @room.building, notice: 'Room was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT buildings/:building_id/rooms/:id
  def update
    if @room.update(room_params)
      redirect_to @room.building, notice: 'Room was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE buildings/:building_id/rooms/:id
  def destroy
    building = @room.building
    @room.destroy
    redirect_to building, notice: 'Room was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def room_params
      params.require(:room).permit(:name, :building_id)
    end
end
