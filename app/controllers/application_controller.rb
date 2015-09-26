class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first
    devise_parameter_sanitizer.for(:sign_up) << :last
    devise_parameter_sanitizer.for(:sign_up) << :avatar
    devise_parameter_sanitizer.for(:sign_up) << :bio
    devise_parameter_sanitizer.for(:sign_up) << :phone
    devise_parameter_sanitizer.for(:sign_up) << :emergency_phone
    devise_parameter_sanitizer.for(:sign_up) << :emergency_name
  end
  
  def ensure_responsibility predicate_method
    unless current_user.send(predicate_method)
      redirect_to (request.referrer || account_path), alert: "Your account does not give access to this action."
    end
  end
  def ensure_coordinator;  ensure_responsibility(:can_coordinate?); end
  def ensure_scheduler; ensure_responsibility(:can_schedule?); end
  def ensure_registrar; ensure_responsibility(:can_register?); end
  def ensure_cataloger; ensure_responsibility(:can_catalog?); end
  def ensure_admin
    unless current_user.is_admin?
      redirect_to (request.referrer || account_path), alert: "Your account does not give access to this action."
    end
  end

  def set_coordinating
    @coordinating = user_signed_in? && current_user.can_coordinate?
  end
  def set_registering
    @registering = user_signed_in? && current_user.can_register?
  end
  def set_scheduling
    @scheduling = user_signed_in? && current_user.can_schedule?
  end
  def set_cataloging
    @cataloging = user_signed_in? && current_user.can_catalog?
  end
  def set_admin
    @admin = user_signed_in? && current_user.is_admin?
  end
end
