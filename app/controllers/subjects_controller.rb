class SubjectsController < ApplicationController
  before_action :authenticate_user!, except: [:show,:index]
  before_action :ensure_cataloger, only: [:new,:create,:edit,:update,:destroy]
  before_action :set_subject, only: [:show, :edit, :update, :destroy]
  before_action :set_cataloging, only: [:index,:show]
  
  def index
    @subjects = Subject.all
  end

  def show
  end

  def new
    @subject = Subject.new
  end

  def edit
  end

  def create
    @subject = Subject.new(subject_params)

    if @subject.save
      redirect_to subjects_path, notice: 'Subject was successfully created.'
    else
      render :new
    end
  end

  def update
    if @subject.update(subject_params)
      redirect_to subjects_path, notice: 'Subject was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @subject.destroy
    redirect_to subjects_path, notice: 'Subject was successfully destroyed.'
  end

  private
    def set_subject
      @subject = Subject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_params
      params.require(:subject).permit(:name, :abbrev)
    end
end
