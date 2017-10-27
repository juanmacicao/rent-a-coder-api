class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def create
    project = Project.new(project_params)
    project.owner = current_user
    project.state = 'open'
    if project.save
      render json: project, status: 201
    else
      render json: { errors: project.errors }, status: 422
    end
  end

  private
  def project_params
    params.permit(:name, :description, :deadline)
  end
end
