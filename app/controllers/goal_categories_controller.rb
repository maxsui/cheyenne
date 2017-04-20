class GoalCategoriesController < ApplicationController

  def index
    @goal_categories = GoalCategory.includes(:goals).order(:name).page(params[:page]).per(20)
  end

  def show
    redirect_to goal_categories_path
  end

  def new
    @goal_category = GoalCategory.new
  end

  def create
    @goal_category = GoalCategory.new goal_category_params
    if @goal_category.save
      redirect_to goal_categories_path
    else
      render "new"
    end
  end

  def edit
    @goal_category = GoalCategory.find params[:id]
  end

  def update
    @goal_category = GoalCategory.find params[:id]
    if @goal_category.update goal_category_params
      redirect_to goal_categories_path
    else
      render "edit"
    end
  end

  def destroy
    @goal_category = GoalCategory.find params[:id]
    @goal_category.destroy

    redirect_to goal_categories_path
  end

  private

  def goal_category_params
    params.require(:goal_category).permit(:name)
  end

end
