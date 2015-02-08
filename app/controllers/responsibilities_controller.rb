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
      redirect_to responsibility_kind_path(:coordination), notice: "Responsibility was successfully added"
    else
      redirect_to responsibility_kind_path(:coordination), alert: "Failed to add responsibility"
    end
  end

  def edit
  end
  
  def update
    if @responsibility.update(resp_params)
      redirect_to responsibility_kind_path(:coordination), notice: "Responsibility was successfully udpated"
    else
      render :edit
    end
  end
  
  def destroy
    @responsibility.destroy
    redirect_to responsibility_kind_path(:coordination), notice: 'Responsibility was successfully removed.'
  end
  
  def kind
    kind = params[:kind]
    case kind
    when "coordination" then ensure_coordinator
    when "cataloging" then ensure_cataloger
    when "scheduling" then ensure_scheduler
    when "registration" then ensure_registrator
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
