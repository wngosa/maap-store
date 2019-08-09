class Site < ApplicationRecord
  OWNERSHIPS = %w[public private].freeze

  validates :name, :address, :location, presence: true
  has_many :patient_id_hashes, dependent: :destroy
  has_many :patients, dependent: :destroy
end
