class SiteSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :location, :ownership, :has_farmacy,
             :created_at, :updated_at, :has_hospital, :has_laboratory,
             :site_type
end
