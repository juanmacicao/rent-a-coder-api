class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :tel, :web, :city, :country
end
