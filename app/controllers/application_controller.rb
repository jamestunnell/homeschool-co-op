class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first
    devise_parameter_sanitizer.for(:sign_up) << :last
    devise_parameter_sanitizer.for(:account_update) << :first
    devise_parameter_sanitizer.for(:account_update) << :last
  end
  
  def ensure_responsibility predicate_method
    unless current_user.send(predicate_method)
      redirect_to request.referrer, notice: "Your account does not give access to this action."
    end
  end
  def ensure_coordinator;  ensure_responsibility(:can_coordinate?); end
  def ensure_scheduler; ensure_responsibility(:can_schedule?); end
  def ensure_registrator; ensure_responsibility(:can_register?); end
  def ensure_cataloger; ensure_responsibility(:can_catalog?); end
end
