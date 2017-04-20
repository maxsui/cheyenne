class ObservablesController < ApplicationController

  def index
    scope = Observable
    if params[:q]
      scope = scope.where("name ilike ?", "%#{params[:q]}%")
    end
    @observables = scope.includes(:goal_observables).order(:name).page(params[:page]).per(20)
  end

  def show
    @observable = Observable.find params[:id]
  end

  def new
    @observable = Observable.new
    @goals = Goal.all
  end

  def create
    @observable = Observable.new observable_params
    if @observable.save
      redirect_to @observable
    else
      @goals = Goal.all
      render "new"
    end
  end

  def edit
    @observable = Observable.find params[:id]
    @goals = Goal.all
  end

  def update
    @observable = Observable.find params[:id]

    if @observable.update observable_params
      redirect_to observables_path
    else
      @goals = Goal.all
      render "edit"
    end
  end

  def destroy
    @observable = Observable.find params[:id]
    @observable.destroy

    redirect_to observables_path
  end

  private

  def observable_params
    params.require(:observable).permit(:name, goal_observables_attributes: [:id, :goal_id, :_destroy])
  end

end