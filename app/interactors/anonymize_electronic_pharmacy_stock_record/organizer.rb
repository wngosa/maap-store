module AnonymizeElectronicPharmacyStockRecord
  class Organizer
    include Interactor::Organizer

    organize Sheets::ReadSheet,
             Sheets::RemoveFields,
             Sheets::SaveSheet,
             Sheets::PruneTableFields,
             S3::Upload
  end
end
