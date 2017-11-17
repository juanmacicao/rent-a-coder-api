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

  private

  def current_user_is_related_to(user)
    projects_in_common = Project.joins(:offers).where(owner_id: current_user.id, offers: { user_id: user.id })
    projects_in_common.count > 0
  end
end
