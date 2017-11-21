class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    user = User.find(params[:id])
    if current_user_is_related_to(user)
      render json: { user: CandidateProfileSerializer.new(user) }
    else
      render json: { errors: 'action denied' }, status: 401
    end
  end

  def profile
    render json: { user: UserSerializer.new(current_user) }
  end

  def update
    if current_user.update(update_params)
      render json: { success: true }
    else
      render json: { errors: current_user.errors }
    end
  end

  private

  def current_user_is_related_to(user)
    projects_in_common = Project.joins(:offers).where(owner_id: current_user.id, offers: { user_id: user.id })
    projects_in_common.count > 0
  end

  def update_params
    if params[:technologies_ids]
      technologies_selected = Technology.where(id: params[:technologies_ids])
      params.permit(:name, :city, :country, :tel, :web).merge(technologies: technologies_selected)
    else
      params.permit(:name, :city, :country, :tel, :web)
    end
  end
end
