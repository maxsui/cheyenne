class NestedSeancesController < ApplicationController

  def index
    @seances = parent.seances
    @seances = @seances.order(:begin).page(params[:page]).per(20)
  end

  private

  def parent
    raise ActionController::RoutingError.new('Not Found') unless params[:project_id]

    @parent = project = Project.find(params[:project_id])
    @parent_name = "Projet de #{project.customer.name}"

    @parent
  end

end
