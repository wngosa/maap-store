class SiteSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :location, :ownership, :has_farmacy,
             :identified_patients, :created_at, :updated_at, :level,
             :teaching, :has_hospital, :has_laboratory
end