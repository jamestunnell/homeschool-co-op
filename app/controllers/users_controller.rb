class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    set_admin
    set_coordinating
    set_registering
    set_scheduling
  end

  def edit
    @user = current_user
  end

  def update
    user_params = params.require(:user).permit(:first,:last,:bio,:avatar,:phone,:emergency_name,:emergency_phone)
    if current_user.update(user_params)
      redirect_to account_path, notice: 'Update was successful.'
    else
      @user = current_user
      render :edit
    end
  end

  def index
    @users = {}

    if @admin = params.has_key?(:admin)
      ensure_admin
    end

    if params.has_key? :show_parents
      enrollments = if params.has_key? :admin
        Enrollment.not_past
      else
        sections = current_user.upcoming_sections + current_user.active_sections
        sections.map {|s| s.enrollments }.flatten
      end
      @users["Parents"] = enrollments.map {|e| e.user }.flatten.uniq
    elsif params.has_key? :show_teachers
      sections = if params.has_key? :admin
        Section.not_past
      else
        enrollments = current_user.upcoming_enrollments + current_user.active_enrollments
        enrollments.map {|e| e.section }
      end
      @users["Teachers"] = sections.map {|s| s.teacher }.uniq
    else
      redirect_to account_path, alert: "Could not complete request"
    end
  end
end
