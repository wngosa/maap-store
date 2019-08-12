class AnonymizeLabRecordImportWorker
  include Sidekiq::Worker

  def perform(lab_record_id, patient_ids = false)
    @lab_record_id = lab_record_id
    logger.info "Starting anonymization of #{lab_record.id}"

    AnonymizeLabRecordImport::Organizer.call(lab_record: lab_record, patient_ids: patient_ids)

    logger.info "Finished anonymization of #{lab_record.id}"
  end

  private

  def lab_record
    @lab_record ||= LabRecordImport.find(@lab_record_id)
  end
end
