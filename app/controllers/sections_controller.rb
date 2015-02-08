class SectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_scheduler, only: [:new,:create,:edit,:update,:destroy]
  before_action :set_section, only: [:show, :edit, :update, :destroy]

  def index
    @sections = Section.all
  end

  def show
  end

  def new
    @section = Section.new
    @section.build_meeting_day_time
  end

  def edit
  end

  def create
    @section = Section.new(section_params)

    if @section.save
      redirect_to scheduling_path, notice: 'Section was successfully created.'
    else
      render :new
    end
  end

  def update
    if @section.update(section_params)
      redirect_to scheduling_path, notice: 'Section was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @section.destroy
    redirect_to scheduling_path, notice: 'Section was successfully destroyed.'
  end

  private
    def set_section
      @section = Section.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def section_params
      params.require(:section).permit(:fee, :term_id, :room_id,
                                      :user_id, :course_id,
                                      meeting_day_time_attributes: [:day, :start_time, :end_time])
    end
end
