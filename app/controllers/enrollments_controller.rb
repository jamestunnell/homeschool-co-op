class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user, only: [:new, :create, :index]
  before_action :set_enrollment, only: [:show, :edit, :update, :destroy]
  
  def new
    @enrollment = Enrollment.new(student_id: params[:student_id])
  end

  def create
    @enrollment = Enrollment.new(enrollment_params)
    if @enrollment.save
      redirect_to student_enrollments_path(@enrollment.student), notice: "Enrollment was successfully added."
    else
      redirect_to student_enrollments_path(@enrollment.student), alert: "Failed to add enrollment"
    end    
  end

  def index
    @student = Student.find(params[:student_id])
    @enrollments = @student.enrollments
  end

  def show
  end

  def edit
  end

  def update
    if @enrollment.update(enrollment_params)
      redirect_to student_enrollments_path(@enrollment.student), notice: 'Enrollment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    student = @enrollment.student
    @enrollment.destroy
    redirect_to student_enrollments_path(student), notice: 'Enrollment was successfully removed.'
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
