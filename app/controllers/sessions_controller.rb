class SessionsController < ApplicationController

  def index
    @date = Date.parse(params[:date]) rescue nil
    @date ||= Date.today

    scope = Session
    scope = scope.by_date(@date) if @date

    @sessions = scope.order(:begin).page(params[:page]).per(20)
  end

  def show
    @session = Session.find params[:id]
  end

  def new
    @session = Session.new
    @customers = Customer.order(:name).all
  end

  def create
    @session = Session.new session_params
    if @session.save
      redirect_to @session
    else
      @customers = Customer.order(:name).all
      render "new"
    end
  end

  def edit
    @session = Session.find params[:id]
    @customers = Customer.order(:name).all
  end

  def update
    @session = Session.find params[:id]

    if @session.update session_params
      redirect_to @session
    else
      @customers = Customer.order(:name).all
      render "edit"
    end
  end

  def destroy
    @session = Session.find params[:id]
    @session.destroy

    redirect_to sessions_path
  end

  private

  def session_params
    params.require(:session).permit(:begin, :end, session_customers_attributes: [:id, :customer_id, :_destroy])
  end

end
