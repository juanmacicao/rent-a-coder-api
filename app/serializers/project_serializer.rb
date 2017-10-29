class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :deadline, :state, :technologies
end
