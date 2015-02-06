class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  #before_action :check_user, only: [:new, :create, :index]
  before_action :set_enrollment, only: [:show, :edit, :update, :destroy]
  
  def new
    if params.has_key?(:child_id)
      child = Child.find(params[:child_id])
      check_user(child.parent)
      @enrollment = child.enrollments.build
    else
      user = User.find(params[:user_id])
      check_user(user)
      @enrollment = user.enrollments.build
    end
  end

  def create
    @enrollment = Enrollment.new(enrollment_params)
    check_user(@enrollment.user_responsible)
    if @enrollment.save
      redirect_to user_enrollments_path(@enrollment.user_responsible), notice: "Enrollment was successfully added."
    else
      redirect_to user_enrollments_path(@enrollment.user_responsible), alert: "Failed to add enrollment"
    end    
  end

  def index
    @user = User.find(params[:user_id])
    check_user(@user)
    @enrollments = @user.all_enrollments
  end

  def show
    check_user(@enrollment.user_responsible)
  end

  def edit
    check_user(@enrollment.user_responsible)
  end

  def update
    check_user(@enrollment.user_responsible)
    if @enrollment.update(enrollment_params)
      redirect_to user_enrollments_path(@enrollment.user_responsible), notice: 'Enrollment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    check_user(@enrollment.user_responsible)
    user = @enrollment.user_responsible
    @enrollment.destroy
    redirect_to user_enrollments_path(user), notice: 'Enrollment was successfully removed.'
  end
  
  private
    def check_user user
      unless current_user == user
        redirect_to user_path(current_user), alert: "You user account does not provide access to this section"
      end
    end

    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enrollment_params
      params.require(:enrollment).permit(:section_id, :enrollable_id, :enrollable_type)
    end
end
