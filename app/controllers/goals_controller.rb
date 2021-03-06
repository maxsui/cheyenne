class GoalsController < ApplicationController

  def index
    @goals = Goal.includes(:goal_category).joins(:goal_category).order("goal_categories.name", :name).page(params[:page]).per(20)
  end

  def show
    @goal = Goal.find params[:id]
  end

  def new
    @goal = Goal.new
    @categories = GoalCategory.all
  end

  def create
    @goal = Goal.new goal_params
    if @goal.save
      redirect_to @goal
    else
      @categories = GoalCategory.all
      render "new"
    end
  end

  def edit
    @goal = Goal.find params[:id]
    @observable_categories = ObservableCategory.all
    @categories = GoalCategory.all
  end

  def update
    @goal = Goal.find params[:id]

    if @goal.update goal_params
      redirect_to goal_path(@goal)
    else
      @observable_categories = ObservableCategory.all
      @categories = GoalCategory.all
      render "edit"
    end
  end

  def destroy
    @goal = Goal.find params[:id]
    @goal.destroy

    redirect_to goals_path
  end

  private

  def goal_params
    params.require(:goal).permit(:name, :goal_category_id, goal_observables_attributes: [:id, :observable_id, :_destroy])
  end

end
