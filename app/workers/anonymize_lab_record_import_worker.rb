class AnonymizeLabRecordImportWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(lab_record_import_id, patient_ids = false)
    @lab_record_import_id = lab_record_import_id
    logger.info "Starting anonymization of #{lab_record_import.id}"

    AnonymizeLabRecordImport::Organizer.call(
      lab_record_import: lab_record_import,
      patient_ids: patient_ids
    )

    logger.info "Finished anonymization of #{lab_record_import.id}"
  end

  private

  def lab_record_import
    @lab_record_import ||= LabRecordImport.find(@lab_record_import_id)
  end
end
