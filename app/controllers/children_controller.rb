class ChildrenController < ApplicationController
  before_action :set_child, only: [:show, :edit, :update, :destroy]
  
  def show
  end
  
  def edit
  end
  
  def create
    @adult = Adult.find(params[:adult_id])
    
    if @adult.children.create(child_params)
      redirect_to @adult, notice: "Child was successfully added."
    else
      redirect_to @adult, alert: "Failed to add child"
    end    
  end
  
  def update
    respond_to do |format|
      adult = @child.adult
      if @child.update(child_params)
        format.html { redirect_to adult, notice: 'Child was successfully updated.' }
        format.json { render :show, status: :ok, location: @child }
      else
        format.html { render :edit }
        format.json { render json: @child.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    adult = @child.adult
    @child.destroy
    respond_to do |format|
      format.html { redirect_to adult, notice: 'Child was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_child
      @child = Child.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def child_params
      params.require(:child).permit(:first, :last, :birth_date)
    end
end
