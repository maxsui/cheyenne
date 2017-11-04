class SceancesController < ApplicationController

  before_action :load_associations, only: [:new, :create, :edit, :update]

  def index
    # @sceances.order(:begin).page(params[:page]).per(20)
    respond_to do |format|
      format.json do
        scope = Sceance
        scope = scope.after(Time.parse(params[:start])) if params[:start]
        scope = scope.before(Time.parse(params[:end])) if params[:end]

        @sceances = scope.all
      end
      format.html
    end
  end

  def show
    @sceance = Sceance.find params[:id]
  end

  def new
    @sceance = Sceance.new
  end

  def create
    @sceance = Sceance.new sceance_params
    if @sceance.save
      redirect_to @sceance
    else
      render "new"
    end
  end

  def edit
    @sceance = Sceance.find params[:id]
  end

  def update
    @sceance = Sceance.find params[:id]

    if @sceance.update sceance_params
      redirect_to @sceance
    else
      render "edit"
    end
  end

  def destroy
    @sceance = Sceance.find params[:id]
    @sceance.destroy

    redirect_to sceances_path
  end

  private

  def load_associations
    @customers = Customer.order(:name).all
    @users = User.order(:name).all
    @groups = Group.order(:name).all
  end

  def sceance_params
    params.require(:sceance).permit(:begin, :end, sceance_customers_attributes: [:id, :customer_id, :_destroy], sceance_users_attributes: [:id, :user_id, :_destroy], sceance_groups_attributes: [:id, :group_id, :_destroy])
  end

end
