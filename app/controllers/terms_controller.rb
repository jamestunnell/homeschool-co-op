class TermsController < ApplicationController
  before_action :set_term, only: [:show, :edit, :update, :destroy]

  # GET /terms
  def index
    @terms = Term.all
  end

  # GET /terms/1
  def show
  end

  # GET /terms/new
  def new
    @term = Term.new
  end

  # GET /terms/1/edit
  def edit
  end

  # POST /terms
  def create
    @term = Term.new(term_params)

    if @term.save
      redirect_to @term, notice: 'Term was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /terms/1
  def update
    if @term.update(term_params)
      redirect_to @term, notice: 'Term was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /terms/1
  def destroy
    @term.destroy
    redirect_to terms_url, notice: 'Term was successfully destroyed.'
  end

  private
    def set_term
      @term = Term.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def term_params
      params.require(:term).permit(:season, :kind, :start_date, :end_date, :workshop)
    end
end
