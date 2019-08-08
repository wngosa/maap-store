class Antibiotic < ApplicationRecord
  validates :name, presence: true

  has_many :antibiotic_consumption_stats, dependent: :destroy
end
