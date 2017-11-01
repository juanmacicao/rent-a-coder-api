class Overrides::RegistrationsController < DeviseTokenAuth::RegistrationsController
  protected

  def render_create_success
    render json: { success: true }
  end
end
