class Site < ApplicationRecord
  OWNERSHIPS = %w[public private mission military other].freeze
  LEVEL = %w[primary secondary tertiary unknown].freeze
  TEACHING = %w[teaching non_teaching unknown].freeze

  validates :name, :address, presence: true
  has_many :patient_id_hashes, dependent: :destroy
  has_many :patients, dependent: :destroy
end
