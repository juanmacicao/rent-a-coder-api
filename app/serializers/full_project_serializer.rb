class FullProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :deadline, :state, :owner

  def owner
    OwnerSerializer.new(object.owner)
  end
end
