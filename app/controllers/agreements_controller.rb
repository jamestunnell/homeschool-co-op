class AgreementsController < ApplicationController
  before_action :check_and_set_kind, only: [:show,:submit, :reset_all]
  before_action :authenticate_user!, only: [:submit,:reset_all]
  before_action :ensure_coordinator, only: [:reset_all]
  before_action :set_coordinating, only: [:show,:index]

  def index
  end

  def show
    render @kind
  end

  def submit
    if params[:agree].present?
      current_user.send("#{@kind}_agreement=".to_sym,true)
      current_user.save
      redirect_to account_path, notice: "Huzzah! Your agreement has been noted"
    else
      redirect_to account_path, alert: "Bummer. Feel free to contact us to discuss the matter"
    end
  end

  # Reset all user agreements for the given kind
  def reset_all
    User.update_all("#{@kind}_agreement".to_sym => false)
    redirect_to agreements_path, notice: "#{@kind.humanize} agreements have all been reset."
  end

  private

  def check_and_set_kind
    @kind = params[:kind]
    case @kind
      when "parent"
      else
        render status: 404
    end
  end
end
