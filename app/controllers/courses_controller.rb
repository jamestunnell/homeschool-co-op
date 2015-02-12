class CoursesController < ApplicationController
  before_action :authenticate_user!, except: [:show,:index]
  before_action :ensure_cataloger, only: [:new,:create,:edit,:update,:destroy]
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :set_cataloging, only: [:index]
  
  def index
    @courses = Course.all
  end

  def show
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to courses_path, notice: 'Course was successfully created.'
    else
      render :new
    end
  end

  def update
    if @course.update(course_params)
      redirect_to courses_path, notice: 'Course was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_path, notice: 'Course was successfully destroyed.'
  end

  private    
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :description, :subject_id, :workshop)
    end
end
