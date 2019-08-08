module AnonymizeLabRecordFile
  class Organizer
    include Interactor::Organizer

    organize AnonymizeLabRecordFile::ReadSheet,
             AnonymizeLabRecordFile::RemoveFields,
             AnonymizeLabRecordFile::SaveSheet
  end
end
