class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    projects_offered = Offer.select(:project_id).where(user_id: current_user.id)
    projects_to_bid = Project.where("owner_id != ? AND id NOT IN (?)", current_user.id, projects_offered)
    render json: {
      projects: projects_to_bid.map { |project| FullProjectSerializer.new(project) }
    }
  end

  def show
    project = Project.find(params[:id])
    if project.owner == current_user
      render json: project
    else
      render json: { errors: "action denied" }
    end
  end

  def create
    project = Project.new(project_params)
    if project.save
      render json: project, status: 201
    else
      render json: { errors: project.errors }, status: 422
    end
  end

  def update
    project = Project.find(params[:id])
    if project.owner != current_user
      render json: { errors: { user: "must be the project owner" } }, status: 422
    elsif !project.candidates.empty?
      render json: { errors: { candidates: "must be empty" } }, status: 422
    elsif project.update(project_params)
      render json: { success: true }, status: 200
    else
      render json: { errors: project.errors }, status: 422
    end
  end

  def assign_developer
    project = Project.find(params[:project_id])
    developer_selected = User.find(params[:developer_id])
    if project.owner != current_user
      project.errors.add(:owner, :invalid)
    elsif project.state != 'offered'
      project.errors.add(:state, :invalid)
    elsif !project.candidates.include?(developer_selected)
      project.errors.add(:developer, :invalid)
    else
      project.developer = developer_selected
      project.state = 'in_progress'
      project.save
    end
    render_response(project)
  end

  def set_developer_score
    project = Project.find(params[:project_id])
    if current_user != project.owner
      project.errors.add(:owner, :invalid)
    elsif project.state != 'in_progress'
      project.errors.add(:state, :invalid)
    else
      project.developer_score = params[:score]
      project.state = 'finished'
      project.save
    end
    render_response(project)
  end

  def set_owner_score
    project = Project.find(params[:project_id])
    if current_user != project.developer
      project.errors.add(:developer, :invalid)
    elsif project.state != 'finished'
      project.errors.add(:state, :invalid)
    else
      project.owner_score = params[:score]
      project.save
    end
    render_response(project)
  end

  private
  def project_params
    technologies = Technology.where(id: params[:technologies_ids])
    params.permit(:name, :description, :deadline).merge(state: 'open', technologies: technologies, owner: current_user, owner_score: 0, developer_score: 0)
  end

  def render_response(project)
    if project.errors.empty? && project.save
      render json: { success: true }, status: 201
    else
      render json: { errors: project.errors }, status: 422
    end
  end
end
