class Lab < ApplicationRecord
  OWNERSHIPS = %w[public private].freeze

  validates :name, :address, :location, presence: true
end
