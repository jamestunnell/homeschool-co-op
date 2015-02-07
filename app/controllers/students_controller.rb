class StudentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  
  def new
    @student = current_user.students.build
  end
  
  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to students_path, notice: "Student was successfully added."
    else
      redirect_to students_path, alert: "Failed to add student"
    end
  end
  
  def index
    @students = current_user.students
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @student.update(student_params)
      redirect_to students_path, notice: 'Student was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    user = @student.user
    @student.destroy
    redirect_to students_path, notice: 'Student was successfully removed.'
  end

  private
    def set_student
      student = Student.find(params[:id])
      unless current_user == student.user
        redirect_to user_path(current_user), alert: "You user account does not provide access to this section"
      end
      @student = student
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:first, :last, :birth_date, :user_id)
    end
end
