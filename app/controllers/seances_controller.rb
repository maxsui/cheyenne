class SeancesController < ApplicationController

  before_action :load_associations, only: [:new, :create, :edit, :update]

  def index
    # @seances.order(:begin).page(params[:page]).per(20)
    respond_to do |format|
      format.json do
        scope = Seance
        scope = scope.after(Time.parse(params[:start])) if params[:start]
        scope = scope.before(Time.parse(params[:end])) if params[:end]

        @seances = scope.all
      end
      format.html
    end
  end

  def show
    @seance = Seance.find params[:id]
  end

  def new
    @seance = Seance.new
  end

  def create
    @seance = Seance.new seance_params
    if @seance.save
      redirect_to @seance
    else
      render "new"
    end
  end

  def edit
    @seance = Seance.find params[:id]
  end

  def update
    @seance = Seance.find params[:id]

    if @seance.update seance_params
      redirect_to @seance
    else
      render "edit"
    end
  end

  def destroy
    @seance = Seance.find params[:id]
    @seance.destroy

    redirect_to seances_path
  end

  def confirm
    @seance = Seance.find params[:id]
    @seance.seance_customers.create customer: Customer.find(params[:candidate_id]), group: Group.find(params[:group_id])

    redirect_to @seance
  end

  private

  def load_associations
    @customers = Customer.order(:name).all
    @users = User.order(:name).all
    @groups = Group.order(:name).all
  end

  def seance_params
    params.require(:seance).permit(:begin, :end, seance_customers_attributes: [:id, :customer_id, :_destroy], seance_users_attributes: [:id, :user_id, :_destroy], seance_groups_attributes: [:id, :group_id, :_destroy])
  end

end
