class CandidatesController < ApplicationController
  before_action :authenticate_user!

  def show
    project = Project.joins(:offers).find(params[:id])
    if project.owner != current_user
      render json: { errors: 'Project not found' }
    else
      render json: { offers: project.offers.map { |offer| OfferSerializer.new(offer) } }
    end
  end
end
