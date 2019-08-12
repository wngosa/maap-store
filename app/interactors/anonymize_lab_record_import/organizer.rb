module AnonymizeLabRecordImport
  class Organizer
    include Interactor::Organizer

    organize AnonymizeLabRecordImport::ReadSheet,
             AnonymizeLabRecordImport::RemoveFields,
             AnonymizeLabRecordImport::SaveSheet
  end
end
