class Patient < ApplicationRecord
  include PatientIdObfuscation

  belongs_to :site

  validates :patient_id, presence: true, uniqueness: { scope: :site_id }

  def self.patient_id_hash_for(patient_id, site_id)
    PatientIdHash.find_or_initialize_by(
      patient_id: patient_id, site_id: site_id
    ) do |patient_id_hash|
      patient_id_hash.hashed_value = SecureRandom.uuid
      patient_id_hash.save
    end.hashed_value
  end
end
