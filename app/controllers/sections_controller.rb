class SectionsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :ensure_scheduler, only: [:new,:create,:edit,:update,:destroy]
  before_action :set_section, only: [:show, :edit, :update, :destroy]

  def index
    sections = current_user.sections
    @sections = {
      "Active" => sections.select {|s| s.term.active? },
      "Upcoming" => sections.select {|s| s.term.upcoming? },
      "Past" => sections.select {|s| s.term.past? },
    }
  end

  def show
    set_scheduling
    set_registering
    set_coordinating
    if user_signed_in? && current_user == @section.user
      @teaching = true
    end
  end

  def new
    @section = Term.find(params[:term_id]).sections.build
    @section.build_meeting_day_time
  end

  def edit
  end

  def create
    @section = Section.new(section_params)

    if @section.save
      redirect_to term_path(@section.term), notice: 'Section was successfully created.'
    else
      render :new
    end
  end

  def update
    if @section.update(section_params)
      redirect_to term_path(@section.term), notice: 'Section was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    term = @section.term
    @section.destroy
    redirect_to term_path(term), notice: 'Section was successfully destroyed.'
  end

  private
    def set_section
      @section = Section.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def section_params
      params.require(:section).permit(:fee, :enrollment_limit,
        :term_id, :room_id, :user_id, :course_id,
        meeting_day_time_attributes: [:day, :start_time, :end_time])
    end
end
