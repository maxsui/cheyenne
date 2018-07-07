class ProjectsController < ApplicationController

  before_action :load_collections, only: [:new, :create, :edit, :update]

  def index
    @projects = Project.page(params[:page]).per(20)
  end

  def show
    @project = Project.find params[:id]
  end

  def new
    @project = Project.new customer_id: params[:customer_id]
  end

  def create
    @project = Project.new project_params
    if @project.save
      redirect_to @project
    else
      render "new"
    end
  end

  def edit
    @project = Project.find params[:id]
  end

  def update
    @project = Project.find params[:id]

    if @project.update project_params
      redirect_to @project
    else
      render "edit"
    end
  end

  def destroy
    @project = Project.find params[:id]
    @project.destroy

    redirect_to projects_path
  end

  def toogle_observable
    @project = Project.find params[:project_id]
    @project_observable = @project.project_observables.find params[:project_observable_id]
    @project_observable.toogle!
  end

  private

  def load_collections
    @customers = Customer.order(:name)
    @goal_categories = GoalCategory.all
  end

  def project_params
    params.require(:project).permit(:begin, :end, :customer_id, project_goals_attributes: [:id, :goal_id, :_destroy])
  end

end
