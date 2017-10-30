class OffersController < ApplicationController
  before_action :authenticate_user!

  def create
    offer = Offer.new(offer_params)
    if offer.save
      render json: offer, status: 201
    else
      render json: { errors: offer.errors }, status: 422
    end
  end

  private
  def offer_params
    params.permit(:cost, :estimated_time, :project_id).merge(user_id: current_user.id)
  end
end
