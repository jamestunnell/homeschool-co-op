class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: [:show, :edit, :update, :destroy]
  
  def show
  end

  def new
    @enrollable
    if params.has_key?(:child_id)
      @enrollment = Child.find(params[:child_id]).enrollments.build
    else
      @enrollment = Adult.find(params[:adult_id]).enrollments.build
    end
  end

  def edit
  end

  def create
    @enrollment = Enrollment.new(enrollment_params)
    if @enrollment.save
      redirect_to @enrollment.enrollable, notice: "Enrollment was successfully added."
    else
      redirect_to @enrollment.enrollable, alert: "Failed to add enrollment"
    end    
  end

  def update
    if @enrollment.update(enrollment_params)
      redirect_to @enrollment.enrollable, notice: 'Enrollment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    enrollable = @enrollment.adult
    @enrollment.destroy
    redirect_to enrollable, notice: 'Enrollment was successfully removed.'
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enrollment_params
      params.require(:enrollment).permit(:section_id, :enrollable_id, :enrollable_type)
    end
end
