class SeanceUpdatesController < ApplicationController

  before_action :load_associations

  def new
    @update = SeanceUpdate.new
  end

  def create
    @update = SeanceUpdate.new seance_update_params
    if @update.save
      redirect_to @update
    else
      render "new"
    end
  end

  def edit
    raise "TODO"
  end

  def update
    raise "TODO"
  end

  def destroy
    raise "TODO"
  end

  private

  def load_associations
    @customers = Customer.order(:name).all
    @users = User.order(:name).all
    @groups = Group.order(:name).all
  end

  def seance_update_params
    # params.require(:seance_update).permit(seance_attributes: [:begin, :end, seance_customers_attributes: [:id, :customer_id, :_destroy], seance_users_attributes: [:id, :user_id, :_destroy], seance_groups_attributes: [:id, :group_id, :_destroy]])
    params.require(:seance_update).permit(:date, :time, :duration, :enable_scheduling, scheduling_attributes: {})
  end

end
