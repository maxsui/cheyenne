class SeanceCustomersController < ApplicationController

  def show
    @seance = Seance.find params[:seance_id]
    @seance_customer = @seance.seance_customers.find params[:id]
  end

  def edit
    @seance = Seance.find params[:seance_id]
    @seance_customer = @seance.seance_customers.find params[:id]
  end

  def update

  end

  def note
    @seance = Seance.find params[:seance_id]
    @seance_customer = @seance.seance_customers.find params[:id]
    @seance_observable = @seance_customer.observables.find params[:seance_customer_observable_id]
    @seance_observable.update note: params[:note], user: current_user
  end

end
