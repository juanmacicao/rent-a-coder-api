class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :nickname, :email, :tel, :web, :city, :country
end
