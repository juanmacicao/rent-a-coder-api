class Overrides::RegistrationsController < DeviseTokenAuth::RegistrationsController

  def create
    technologies = Technology.where(id: params[:technologies_ids])
    params.delete :technologies_ids
    super do |resource|
      resource.technologies = technologies
      resource.save
    end
  end

  protected

  def render_create_success
    render json: { success: true }
  end
end
