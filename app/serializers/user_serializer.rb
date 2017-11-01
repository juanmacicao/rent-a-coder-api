class UserSerializer < ActiveModel::Serializer
  attributes :name, :nickname, :email, :tel, :web, :city, :country, :gravatar_url, :uploaded_projects

  def gravatar_url
    gravatar_id = Digest::MD5::hexdigest(object.email).downcase
    url = "http://gravatar.com/avatar/#{gravatar_id}.png"
  end
end
