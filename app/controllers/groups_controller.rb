class GroupsController < ApplicationController

  def index
    scope = Group
    if params[:q]
      scope = scope.where("name ilike ?", "%#{params[:q]}%")
    end
    @groups = scope.order(:name).page(params[:page]).per(20)
  end

  def show
    @group = Group.find params[:id]
  end

  def new
    @group = Group.new
    @customers = Customer.order(:name).all
  end

  def create
    @group = Group.new group_params
    if @group.save
      redirect_to @group
    else
      @customers = Customer.order(:name).all
      render "new"
    end
  end

  def edit
    @group = Group.find params[:id]
    @customers = Customer.order(:name).all
  end

  def update
    @group = Group.find params[:id]

    if @group.update group_params
      redirect_to @group
    else
      @customers = Customer.order(:name).all
      render "edit"
    end
  end

  def destroy
    @group = Group.find params[:id]
    @group.destroy

    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, group_memberships_attributes: [:id, :customer_id, :_destroy])
  end

end
