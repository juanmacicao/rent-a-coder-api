class OffersController < ApplicationController
  before_action :authenticate_user!

  def create
    offer = Offer.new(offer_params)
    if offer.save
      update_project_state(offer.project)
      render json: offer, status: 201
    else
      render json: { errors: offer.errors }, status: 422
    end
  end

  private
  def offer_params
    params.permit(:cost, :estimated_time, :project_id).merge(user_id: current_user.id)
  end

  def update_project_state(project)
    if project.state == 'open'
      project.state = 'offered'
      project.save
    end
  end
end
