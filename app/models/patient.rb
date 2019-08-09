class Patient < ApplicationRecord
  include PatientIdObfuscation

  validates :patient_id, presence: true, uniqueness: { scope: :site_id }
end
