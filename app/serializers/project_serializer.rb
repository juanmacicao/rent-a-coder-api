class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :deadline, :state

  has_many :technologies
end
