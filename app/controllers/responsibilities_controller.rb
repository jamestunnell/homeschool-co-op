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
  
  def method_missing method
    super
  end
  private
    def ensure_responsibility predicate_method
      unless current_user.send(predicate_method)
        redirect_to root_path, alert: "You are not authorized to take this action"
      end
    end
    def ensure_coordinator;  ensure_responsibility(:can_coordinate?); end
    def ensure_scheduler; ensure_responsibility(:can_schedule?); end
    def ensure_registrator; ensure_responsibility(:can_register?); end
    def ensure_cataloger; ensure_responsibility(:can_catalog?); end
    
    def resp_params
      params.require(:responsibility).permit(:kind,:user_id,:start_date,:end_date)
    end
    
    def set_responsibility
      @responsibility = Responsibility.find(params[:id])
    end
end
