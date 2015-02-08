class BuildingsController < ApplicationController
  before_action :authenticate_user!, except: [:show,:index]
  before_action :ensure_scheduler, only: [:new,:create,:edit,:update,:destroy]
  before_action :set_building, only: [:show, :edit, :update, :destroy]

  def index
    @buildings = Building.all
  end

  def new
    @building = Building.new
    @building.build_address
  end

  def create
    @building = Building.new(building_params)
    
    if @building.save
      redirect_to responsibility_kind_path(:scheduling), notice: 'Building was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @building.update(building_params)
      redirect_to responsibility_kind_path(:scheduling), notice: 'Building was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @building.destroy
    redirect_to responsibility_kind_path(:scheduling), notice: 'Building was successfully destroyed.'
  end

  private
    def set_building
      @building = Building.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def building_params
      params.require(:building).permit(:name, address_attributes: [:street, :city, :state, :zip])
    end
end
