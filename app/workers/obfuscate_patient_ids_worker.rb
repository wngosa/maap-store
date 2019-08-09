class ObfuscatePatientIdsWorker
  include Sidekiq::Worker

  def perform
    Patient.obfuscation_pending.find_each do |patient|
      Rails.logger.info "Obfuscating #{patient.id}"
      patient.patient_id = patient_id_hash_for(patient.patient_id, patient.site_id).hashed_value
      patient.patient_id_state = 'obfuscated'
      patient.save!
    end
  end

  private

  def patient_id_hash_for(patient_id, site_id)
    PatientIdHash.find_or_initialize_by(patient_id: patient_id,
                                        site_id: site_id) do |patient_id_hash|
      patient_id_hash.hashed_value = SecureRandom.uuid
      patient_id_hash.save
    end
  end
end
