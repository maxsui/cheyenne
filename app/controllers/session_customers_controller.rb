class SessionCustomersController < ApplicationController

  def show
    @session = Session.find params[:session_id]
    @session_customer = @session.session_customers.find params[:id]
  end

  def edit
    @session = Session.find params[:session_id]
    @session_customer = @session.session_customers.find params[:id]
  end

  def update

  end

  def note
    @session = Session.find params[:session_id]
    @session_customer = @session.session_customers.find params[:id]
    @session_observable = @session_customer.observables.find params[:session_customer_observable_id]
    @session_observable.update note: params[:note], user: current_user
  end

end
