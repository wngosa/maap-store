class Lab < ApplicationRecord
  OWNERSHIPS = %w[a b].freeze

  validates :name, :address, :location, presence: true
end
