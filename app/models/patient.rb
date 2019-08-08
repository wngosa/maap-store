class Patient < ApplicationRecord
  include PatientIdObfuscation

  validates :patient_id, presence: true, uniqueness: :lab_id
end
