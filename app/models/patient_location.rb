class PatientLocation < ApplicationRecord
  validates :name, presence: true
end
