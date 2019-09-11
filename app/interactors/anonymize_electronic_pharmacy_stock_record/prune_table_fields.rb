module AnonymizeElectronicPharmacyStockRecord
  class PruneTableFields
    include Interactor

    def call
      Rails.logger.info "Pruning raw rows for Lab record import #{context.electronic_pharmacy_stock_record.id}"
      context.electronic_pharmacy_stock_record.rows = {}
      context.electronic_pharmacy_stock_record.obfuscation_state = :obfuscated
      context.electronic_pharmacy_stock_record.save!
    end
  end
end
