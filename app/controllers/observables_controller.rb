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
    @goal_categories = GoalCategory.all
    @categories = ObservableCategory.all
  end

  def create
    @observable = Observable.new observable_params
    if @observable.save
      redirect_to @observable
    else
      @goal_categories = GoalCategory.all
      @categories = ObservableCategory.all
      render "new"
    end
  end

  def edit
    @observable = Observable.find params[:id]
    @goal_categories = GoalCategory.all
    @categories = ObservableCategory.all
  end

  def update
    @observable = Observable.find params[:id]

    if @observable.update observable_params
      redirect_to @observable
    else
      @goal_categories = GoalCategory.all
      @categories = ObservableCategory.all
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
    params.require(:observable).permit(:name, :observable_category_id, goal_observables_attributes: [:id, :goal_id, :_destroy])
  end

end
