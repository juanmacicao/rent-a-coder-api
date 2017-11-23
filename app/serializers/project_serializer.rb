class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :deadline, :state, :owner_score, :developer_score

  has_many :technologies
end
