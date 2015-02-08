class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_enrollment, only: [ :pay, :edit, :update, :destroy]
  
  def new
    sid = nil
    if params.has_key? :student_id
      check_user
      sid = params[:student_id]
    end
    @enrollment = Enrollment.new(student_id: sid)
  end

  def create
    unless current_user == Student.find(enrollment_params[:student_id]).user
      redirect_to enrollments_path, alert: "You user account does not provide access to this section"
    end
    
    @enrollment = Enrollment.new(enrollment_params)
    if @enrollment.save
      redirect_to enrollments_path, notice: "Enrollment was successfully added."
    else
      redirect_to enrollments_path, alert: "Failed to add enrollment"
    end    
  end

  def index
    @enrollments = current_user.enrollments
  end
  
  def edit
  end

  def update
    if @enrollment.update(enrollment_params)
      redirect_to enrollments_path, notice: 'Enrollment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @enrollment.destroy
    redirect_to enrollments_path, notice: 'Enrollment was successfully removed.'
  end
  
  def mark_paid
    unless current_user.can_register?
      redirect_to request.referrer, notice: "Your account does not give access to this action."
    end
    
    @enrollment = Enrollment.find(params[:enrollment_id])
    if @enrollment.paid?
      redirect_to request.referrer, alert: "Enrollment has already been paid"
    else
      @enrollment.paid = true
      if @enrollment.save
        redirect_to request.referrer, notice: "Enrollment has now been paid"
      else
        redirect_to request.referrer, alert: "Enrollment could not be paid"
      end
    end
  end
  
  private
    def check_user
      unless current_user == Student.find(params[:student_id]).user
        redirect_to user_path(current_user), alert: "You user account does not provide access to this section"
      end
    end

    def set_enrollment
      enrollment = Enrollment.find(params[:id])
      unless current_user == enrollment.student.user
        redirect_to user_path(current_user), alert: "You user account does not provide access to this section"
      end
      @enrollment = enrollment
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enrollment_params
      params.require(:enrollment).permit(:section_id, :student_id)
    end
end
