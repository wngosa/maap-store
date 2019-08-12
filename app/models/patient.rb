class Patient < ApplicationRecord
  include PatientIdObfuscation

  belongs_to :site

  validates :patient_id, presence: true, uniqueness: { scope: :site_id }
end
