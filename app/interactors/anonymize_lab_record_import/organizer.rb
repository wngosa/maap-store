module AnonymizeLabRecordImport
  class Organizer
    include Interactor::Organizer

    organize Sheets::ReadSheet,
             AnonymizeLabRecordImport::ObfuscatePatientIds,
             Sheets::RemoveFields,
             Sheets::SaveSheet,
             Sheets::PruneTableFields
    # S3::Upload
  end
end
