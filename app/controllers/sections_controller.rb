class SectionsController < ApplicationController
  before_action :set_section, only: [:show, :edit, :update, :destroy]

  # GET /terms/:term_id/sections/:id
  def show
  end

  # GET /terms/:term_id/sections/new
  def new
    @section = Section.new(term_id: params[:term_id])
    start_day = @section.term.start_date.strftime("%a")
    @section.build_meeting_day_time(day: start_day)
  end

  # GET /terms/:term_id/sections/:id/edit
  def edit
  end

  # POST /terms/:term_id/sections
  def create
    @section = Section.new(section_params)

    if @section.save
      redirect_to @section.term, notice: 'Section was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /terms/:term_id/sections/:id
  def update
    if @section.update(section_params)
      redirect_to @section.term, notice: 'Section was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /terms/:term_id/sections/:id
  def destroy
    term = @section.term
    @section.destroy
    redirect_to term, notice: 'Section was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      @section = Section.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def section_params
      params.require(:section).permit(:fee, :term_id, :room_id,
                                      :adult_id, :course_id,
                                      meeting_day_time_attributes: [:day, :start_time, :end_time])
    end
end
