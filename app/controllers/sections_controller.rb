class SectionsController < ApplicationController
  before_action :set_section, only: [:show, :edit, :update, :destroy]

  # GET /sessions/:session_id/sections/:id
  def show
  end

  # GET /sessions/:session_id/sections/new
  def new
    @section = Section.new(session_id: params[:session_id])
    start_day = @section.session.start_date.strftime("%a")
    @section.build_meeting_day_time(day: start_day)
  end

  # GET /sessions/:session_id/sections/:id/edit
  def edit
  end

  # POST /sessions/:session_id/sections
  def create
    @section = Section.new(section_params)

    if @section.save
      redirect_to [@section.session,@section], notice: 'Section was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /sessions/:session_id/sections/:id
  def update
    if @section.update(section_params)
      redirect_to [@section.session, @section], notice: 'Section was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /sessions/:session_id/sections/:id
  def destroy
    session = @section.session
    @section.destroy
    redirect_to session_url(session), notice: 'Section was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      @section = Section.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def section_params
      params.require(:section).permit(:fee, :session_id, :room_id,
                                      :adult_id, :course_id,
                                      meeting_day_time_attributes: [:day, :start_time, :end_time])
    end
end
