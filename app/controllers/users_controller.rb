class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: { user: UserSerializer.new(current_user) }
  end
end
