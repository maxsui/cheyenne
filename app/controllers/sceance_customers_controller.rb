class SceanceCustomersController < ApplicationController

  def show
    @sceance = Sceance.find params[:sceance_id]
    @sceance_customer = @sceance.sceance_customers.find params[:id]
  end

  def edit
    @sceance = Sceance.find params[:sceance_id]
    @sceance_customer = @sceance.sceance_customers.find params[:id]
  end

  def update

  end

  def note
    @sceance = Sceance.find params[:sceance_id]
    @sceance_customer = @sceance.sceance_customers.find params[:id]
    @sceance_observable = @sceance_customer.observables.find params[:sceance_customer_observable_id]
    @sceance_observable.update note: params[:note], user: current_user
  end

end
