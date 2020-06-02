module InteractorsLRI
  class HashPatientsInRecords
    include Interactor

    def call # rubocop:disable Metrics/AbcSize
      Rails.logger.info 'Patients hashing in Lab Records started'
      obfuscate_patients
      lab_record_import = context.record
      lab_record_import.lab_records.obfuscation_pending.find_each(batch_size: 500) do |lr|
        lr.patient_id = patient_id_hash_for(lr.patient_id, lr.site_id) if lr.patient_id.present?
        lr.patient_id_state = 'obfuscated'
        lr.save!
      end
      Rails.logger.info 'Patients hashing in Lab Records finished'
    end

    private

    def patient_id_hash_for(patient_id, site_id)
      PatientIdHash.find_or_initialize_by(
        patient_id: patient_id, site_id: site_id
      ) do |patient_id_hash|
        patient_id_hash.hashed_value = SecureRandom.uuid
        patient_id_hash.save
      end.hashed_value
    end

    def obfuscate_patients
      Patient.obfuscation_pending.find_each do |patient|
        Rails.logger.info "Obfuscating patient#{patient.id}"
        patient.patient_id = patient_id_hash_for(patient.patient_id, patient.site_id)
        patient.patient_id_state = 'obfuscated'
        patient.save!
      end
    end
  end
end
