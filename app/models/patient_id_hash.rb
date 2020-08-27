class PatientIdHash < ApplicationRecord
  validates :hashed_value, presence: true, uniqueness: true

  belongs_to :site
end
