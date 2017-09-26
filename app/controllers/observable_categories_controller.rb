class ObservableCategoriesController < ApplicationController

  def index
    @observable_categories = ObservableCategory.includes(:observables).order(:name).page(params[:page]).per(20)
  end

  def show
    redirect_to observable_categories_path
  end

  def new
    @observable_category = ObservableCategory.new
  end

  def create
    @observable_category = ObservableCategory.new observable_category_params
    if @observable_category.save
      redirect_to observable_categories_path
    else
      render "new"
    end
  end

  def edit
    @observable_category = ObservableCategory.find params[:id]
  end

  def update
    @observable_category = ObservableCategory.find params[:id]
    if @observable_category.update observable_category_params
      redirect_to observable_categories_path
    else
      render "edit"
    end
  end

  def destroy
    @observable_category = ObservableCategory.find params[:id]
    @observable_category.destroy

    redirect_to observable_categories_path
  end

  private

  def observable_category_params
    params.require(:observable_category).permit(:name)
  end

end
