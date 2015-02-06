class ChildrenController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user, only: [:new, :create, :index]
  before_action :set_child, only: [:show, :edit, :update, :destroy]
  
  def new
    @child = Child.new(user_id: params[:user_id])
  end
  
  def create
    @child = Child.new(child_params)
    if @child.save
      redirect_to user_children_path(@child.user), notice: "Child was successfully added."
    else
      redirect_to user_children_path(@child.user), alert: "Failed to add child"
    end
  end
  
  def index
    @user = User.find(params[:user_id])
    @children = @user.children
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @child.update(child_params)
      redirect_to user_children_path(@child.user), notice: 'Child was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    user = @child.user
    @child.destroy
    redirect_to user_children_path(user), notice: 'Child was successfully removed.'
  end

  private
    def check_user
      unless current_user == User.find(params[:user_id])
        redirect_to user_path(current_user), alert: "You user account does not provide access to this section"
      end
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_child
      child = Child.find(params[:id])
      unless current_user == child.user
        redirect_to user_path(current_user), alert: "You user account does not provide access to this section"
      end
      @child = child
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def child_params
      params.require(:child).permit(:first, :last, :birth_date, :user_id)
    end
end
