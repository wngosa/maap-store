class AnonymizeElectronicPharmacyStockRecordWorker
  include Sidekiq::Worker

  sidekiq_options retry: 3

  def perform(record_id)
    @record_id = record_id
    logger.info "Starting anonymization of #{electronic_pharmacy_stock_record.id}"

    AnonymizeElectronicPharmacyStockRecord::Organizer.call(
      record: electronic_pharmacy_stock_record,
      state_attribute: :obfuscation_state
    )

    logger.info "Finished anonymization of #{electronic_pharmacy_stock_record.id}"
  end

  private

  def electronic_pharmacy_stock_record
    @electronic_pharmacy_stock_record ||= ElectronicPharmacyStockRecord.find(@record_id)
  end
end
