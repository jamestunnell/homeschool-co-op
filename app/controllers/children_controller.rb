class ChildrenController < ApplicationController
  before_action :set_child, only: [:show, :edit, :update, :destroy]
  
  def show
  end
  
  def edit
  end
  
  def new
    @child = Child.new(adult_id: params[:adult_id])
  end
  
  def create
    @child = Child.new(child_params)
    if @child.save
      redirect_to @child.adult, notice: "Child was successfully added."
    else
      redirect_to @child.adult, alert: "Failed to add child"
    end    
  end
  
  def update
    if @child.update(child_params)
      redirect_to @child.adult, notice: 'Child was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    adult = @child.adult
    @child.destroy
    redirect_to adult, notice: 'Child was successfully removed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_child
      @child = Child.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def child_params
      params.require(:child).permit(:first, :last, :birth_date, :adult_id)
    end
end
