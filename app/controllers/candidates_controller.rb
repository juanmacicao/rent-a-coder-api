class CandidatesController < ApplicationController
  before_action :authenticate_user!

  def show
    project = Project.find(params[:id])
    if project.owner != current_user
      render json: { errors: 'Project not found' }
    else
      render json: { candidates: project.candidates }
    end
  end
end
