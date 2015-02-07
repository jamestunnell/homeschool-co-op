class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  # GET /users/1
  def show
  end
  
  def edit
  end
  
  def update
    if @user.update(user_name_params)
      redirect_to user_path(@user), notice: 'Name was successfully updated.'
    else
      render :edit
    end

  end

  private
    def set_user
      user = User.find(params[:id])
      unless current_user == user
        redirect_to user_path(current_user), alert: "You user account does not provide access to this section"
      end
      @user = current_user
    end
    
    def user_name_params
      params.require(:user).permit(:first, :last)
    end
end
