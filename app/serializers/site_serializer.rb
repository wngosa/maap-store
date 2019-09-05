class SiteSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :ownership, :has_pharmacy, :created_at,
             :updated_at, :has_hospital, :has_laboratory, :has_cms, :site_type
end
