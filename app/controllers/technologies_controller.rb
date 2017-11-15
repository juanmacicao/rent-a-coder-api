class TechnologiesController < ApplicationController

  def index
    technologies = Technology.all
    render json: {
      technologies: technologies.map { |technology| TechnologySerializer.new(technology) }
    }
  end
end
