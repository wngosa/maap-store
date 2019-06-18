class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :uid, :provider, :name
end
