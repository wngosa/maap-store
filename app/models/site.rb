class Site < ApplicationRecord
  OWNERSHIPS = %w[public private mission military other].freeze
  LEVEL = %w[primary secondary tertiary unknown].freeze
  TEACHING = %w[teaching non_teaching unknown].freeze

  validates :name, :address, :location, presence: true
end
