class ResponsibilitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_coordinator, only: [:new,:create,:edit,:update,:destroy]
  before_action :set_responsibility, only: [:edit,:update,:destroy]

  def index
  end
  
  def new
    @responsibility = Responsibility.new
  end
  
  def create
    @responsibility = Responsibility.new(resp_params)
    if @responsibility.save
      redirect_to coordination_path, notice: "Responsibility was successfully added"
    else
      redirect_to coordination_path, alert: "Failed to add responsibility"
    end
  end

  def edit
  end
  
  def update
    if @responsibility.update(resp_params)
      redirect_to coordination_path, notice: "Responsibility was successfully udpated"
    else
      render :edit
    end
  end
  
  def destroy
    @responsibility.destroy
    redirect_to coordination_path, notice: 'Responsibility was successfully removed.'
  end
  
  def coordination
    ensure_coordinator
  end

  def registration
    ensure_registrator
  end
  
  def scheduling
    ensure_scheduler
  end
  
  def cataloging
    ensure_cataloger
  end
  
  private
    def resp_params
      params.require(:responsibility).permit(:kind,:user_id,:start_date,:end_date)
    end
    
    def set_responsibility
      @responsibility = Responsibility.find(params[:id])
    end
end
