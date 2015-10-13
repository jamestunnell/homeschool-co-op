class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_enrollment, only: [ :pay, :destroy]
  before_action :ensure_registrar, only: [ :mark_paid ]
  before_action :ensure_parent_agreement, only: [:new,:create]

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

    unless @enrollment.section.enrollment_limit_met?
      if @enrollment.save
        redirect_to enrollments_path, notice: "Enrollment was successfully added."
      else
        redirect_to enrollments_path, alert: "Failed to add enrollment"
      end
    else
      redirect_to enrollments_path, alert: "Failed to add enrollment. Enrollment limit for the section has been met"
    end
  end

  def index
    @enrollments = {}

    if params.has_key? :registering
      ensure_registrar
      set_registering

      @enrollments[:upcoming] = Enrollment.upcoming
      @enrollments[:active] = Enrollment.active
      @enrollments[:past] = Enrollment.past
    else
      @enrollments[:upcoming] = current_user.upcoming_enrollments
      @enrollments[:active] = current_user.active_enrollments
      @enrollments[:past] = current_user.past_enrollments
    end
  end

  def destroy
    @enrollment.destroy
    redirect_to (request.referrer || enrollments_path), notice: 'Enrollment was successfully removed.'
  end
  
  def mark_paid
    @enrollment = Enrollment.find(params[:enrollment_id])
    if @enrollment.paid?
      redirect_to (request.referrer || account_path), alert: "Enrollment has already been paid"
    else
      @enrollment.paid = true
      if @enrollment.save
        redirect_to (request.referrer || account_path), notice: "Enrollment has now been paid"
      else
        redirect_to (request.referrer || account_path), alert: "Enrollment could not be paid"
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
        redirect_to account_path, notice: "Your account does not give access to this action."
      end
      @enrollment = enrollment
    end

    def ensure_parent_agreement
      unless current_user.parent_agreement
        redirect_to agreement_path(:parent), alert: "You must read the latest parent agreement before adding enrollments"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enrollment_params
      params.require(:enrollment).permit(:section_id, :student_id)
    end
end
