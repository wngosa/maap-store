module InteractorsLRI
  class Organizer
    include Interactor::Organizer

    organize InteractorsLRI::InsertLabRecords,
             InteractorsLRI::HashPatientsInRecords,
             Sheets::ReadSheet,
             InteractorsLRI::HashPatientsInFile,
             Sheets::ObfuscateFields,
             Sheets::SaveSheet,
             Sheets::PurgeRowsFile,
             S3::Upload,
             Harakiri

    def call # rubocop:disable AbcSize
      super
    rescue StandardError => e
      return context unless context.state_attribute && context.record

      Rails.logger.info "Error when processing LabRecordImport #{context.record.id}"
      Rails.logger.info e.inspect
      context.record[context.state_attribute] = :error
      context.record.raw_error_message = e.inspect
      context.record.save!
      # Force workers container to release retained memory
      Harakiri.call
      # Re-raise error here to force job to fail and be restarted again
      raise StandardError, e.inspect
    end
  end
end
