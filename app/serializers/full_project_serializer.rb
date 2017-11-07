class FullProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :deadline, :state, :owner

  has_many :technologies

  def owner
    OwnerSerializer.new(object.owner)
  end
end
