class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    projects_offered = Offer.select(:project_id).where(user_id: current_user.id)
    projects_to_bid = Project.where("owner_id != ? AND id NOT IN (?)", current_user.id, projects_offered)
    render json: {
      projects: projects_to_bid.map { |project| FullProjectSerializer.new(project) }
    }
  end

  def create
    project = Project.new(project_params)
    if project.save
      render json: project, status: 201
    else
      render json: { errors: project.errors }, status: 422
    end
  end

  private
  def project_params
    technologies = Technology.where(id: params[:technologies_ids])
    params.permit(:name, :description, :deadline).merge(state: 'open', technologies: technologies, owner: current_user)
  end
end
