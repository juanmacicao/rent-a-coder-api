class Overrides::SessionsController < DeviseTokenAuth::SessionsController
  protected

  def render_create_success
    render json: { success: true }
  end
end
