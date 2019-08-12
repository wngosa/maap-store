module AnonymizeLabRecordImport
  class Organizer
    include Interactor::Organizer

    organize AnonymizeLabRecordImport::ReadSheet,
             AnonymizeLabRecordImport::ObfuscatePatientIds,
             AnonymizeLabRecordImport::RemoveFields,
             AnonymizeLabRecordImport::SaveSheet
  end
end
