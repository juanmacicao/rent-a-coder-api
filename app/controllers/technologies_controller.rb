class TechnologiesController < ApplicationController
  before_action :authenticate_user!

  def index
    technologies = Technology.all
    render json: {
      technologies: technologies.map { |technology| TechnologySerializer.new(technology) }
    }
  end
end
