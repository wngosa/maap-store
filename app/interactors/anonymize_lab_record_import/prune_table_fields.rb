module AnonymizeLabRecordImport
  class PruneTableFields
    include Interactor

    def call
      Rails.logger.info "Pruning raw rows for Lab record import #{context.lab_record_import.id}"
      context.lab_record_import.rows = {}
      context.lab_record_import.patient_id_state = :obfuscated
      context.lab_record_import.save!
    end
  end
end
