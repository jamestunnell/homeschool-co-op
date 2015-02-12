class ResponsibilitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_coordinator, only: [:new,:create,:edit,:update,:destroy]
  before_action :set_responsibility, only: [:edit,:update,:destroy]

  def index
    if params.has_key? :coordinating
      ensure_coordinator
      set_coordinating
      @responsibilities = Responsibility.all
      @name = "All"
    else
      @responsibilities = current_user.responsibilities
      @name = "Your"
    end
  end
  
  def new
    @responsibility = Responsibility.new
  end
  
  def create
    @responsibility = Responsibility.new(resp_params)
    if @responsibility.save
      redirect_to responsibilities_path(coordinating: true), notice: "Responsibility was successfully added"
    else
      redirect_to responsibilities_path(coordinating: true), alert: "Failed to add responsibility"
    end
  end

  def edit
  end
  
  def update
    if @responsibility.update(resp_params)
      redirect_to responsibilities_path(coordinating: true), notice: "Responsibility was successfully udpated"
    else
      render :edit
    end
  end
  
  def destroy
    @responsibility.destroy
    redirect_to responsibilities_path(coordinating: true), notice: 'Responsibility was successfully removed.'
  end
  
  def kind
    kind = params[:kind]
    case kind
    when "coordination" then ensure_coordinator
    when "cataloging" then ensure_cataloger
    when "scheduling" then ensure_scheduler
    when "registration" then ensure_registrar
    else
      redirect_to :status => 404
    end
    render kind.to_sym
  end
    
  private
    def resp_params
      params.require(:responsibility).permit(:kind,:user_id,:start_date,:end_date)
    end
    
    def set_responsibility
      @responsibility = Responsibility.find(params[:id])
    end
end
