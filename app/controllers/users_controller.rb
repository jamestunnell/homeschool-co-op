class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  # GET /users/1
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      user = User.find(params[:id])
      unless current_user == user
        flash[:error] = "You user account does not provide access to this section"
        redirect_to user_path(current_user)
      end
      @user = current_user
    end
end
