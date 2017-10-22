class Overrides::RegistrationsController < DeviseTokenAuth::RegistrationsController
  protected

  def render_create_success
    render json: { user: UserSerializer.new(@resource).as_json }
  end
end
