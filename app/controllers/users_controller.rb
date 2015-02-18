class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    user_params = params.require(:user).permit(:first,:last,:bio,:avatar,:phone,:emergency_name,:emergency_phone)
    if current_user.update(user_params)
      redirect_to account_path, notice: 'Update was successful.'
    else
      @user = current_user
      render :edit
    end
  end
end
