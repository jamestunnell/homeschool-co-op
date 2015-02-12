class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_enrollment, only: [ :pay, :edit, :update, :destroy]
  before_action :ensure_registrar, only: [ :mark_paid ]

  def new
    unless current_user.students.any?
      redirect_to enrollments_path, alert: "There are no students to enroll"
    end
    unless Section.not_past.any?
      redirect_to enrollments_path, alert: "There are no upcoming or active sections to enroll in"
    end
    @enrollment = Enrollment.new
  end

  def create
    @enrollment = Enrollment.new(enrollment_params)
    if @enrollment.save
      redirect_to enrollments_path, notice: "Enrollment was successfully added."
    else
      redirect_to enrollments_path, alert: "Failed to add enrollment"
    end
  end

  def index
    if params.has_key? :registering
      ensure_registrar
      set_registering
      @enrollments = Enrollment.all
      @name = "All"
    else
      @enrollments = current_user.enrollments
      @name = "Your"
    end
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
        redirect_to request.referrer, notice: "Your account does not give access to this action."
      end
    end

    def set_enrollment
      enrollment = Enrollment.find(params[:id])
      unless current_user == enrollment.student.user
        redirect_to current_user, notice: "Your account does not give access to this action."
      end
      @enrollment = enrollment
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enrollment_params
      params.require(:enrollment).permit(:section_id, :student_id)
    end
end
