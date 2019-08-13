class ObfuscatePatientIdsWorker
  include Sidekiq::Worker

  def perform
    obfuscate_patients

    ActiveRecord::Base.transaction do
      obfuscate_lab_records.map do |lab_record_import_id|
        AnonymizeLabRecordImportWorker.perform_async(lab_record_import_id, true)
      end
    end
  end

  private

  def obfuscate_patients
    Patient.obfuscation_pending.find_each do |patient|
      Rails.logger.info "Obfuscating patient#{patient.id}"
      patient.patient_id = patient_id_hash_for(patient.patient_id, patient.site_id).hashed_value
      patient.patient_id_state = 'obfuscated'
      patient.save!
    end
  end

  def obfuscate_lab_records
    lab_record_imports = Set.new
    LabRecord.obfuscation_pending.find_each do |lab_record|
      Rails.logger.info "Obfuscating lab record #{lab_record.id}"

      lab_record.patient_id =
        patient_id_hash_for(lab_record.patient_id, lab_record.site_id).hashed_value
      lab_record.patient_id_state = 'obfuscated'
      lab_record.save!
      lab_record_imports << lab_record.lab_record_import_id
    end
    Rails.logger.info 'Obfuscated lab records'
    lab_record_imports.uniq
  end

  def patient_id_hash_for(patient_id, site_id)
    PatientIdHash.find_or_initialize_by(patient_id: patient_id,
                                        site_id: site_id) do |patient_id_hash|
      patient_id_hash.hashed_value = SecureRandom.uuid
      patient_id_hash.save
    end
  end
end
