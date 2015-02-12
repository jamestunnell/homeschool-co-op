class TermsController < ApplicationController
  before_action :authenticate_user!, except: [:show,:index]
  before_action :ensure_scheduler, only: [:new,:create,:edit,:update,:destroy]
  before_action :set_term, only: [:show, :edit, :update, :destroy]
  before_action :set_scheduling, only: [:index,:show]

  def index
    @terms = Term.all
  end

  def show
  end

  def new
    @term = Term.new
  end

  def edit
  end

  def create
    @term = Term.new(term_params)

    if @term.save
      redirect_to terms_path, notice: 'Term was successfully created.'
    else
      render :new
    end
  end

  def update
    if @term.update(term_params)
      redirect_to terms_path, notice: 'Term was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @term.destroy
    redirect_to terms_path, notice: 'Term was successfully destroyed.'
  end

  private
    def set_term
      @term = Term.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def term_params
      params.require(:term).permit(:kind, :start_date, :end_date, :workshop)
    end
end
