module InteractorsLRI
  class HashPatientsInRecords
    include Interactor

    def call
      Rails.logger.info 'Patients hashing in Lab Records started'
      lab_record_import = context.record
      lab_record_import.lab_records.obfuscation_pending.find_each(batch_size: 500) do |lr|
        if lr.patient_id.present?
          lr.patient_id =
            Patient.patient_id_hash_for(lr.patient_id, lr.site_id)
        end
        lr.patient_id_state = 'obfuscated'
        lr.save!
      end
      Rails.logger.info 'Patients hashing in Lab Records finished'
    end
  end
end
