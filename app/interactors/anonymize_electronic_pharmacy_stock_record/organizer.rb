module AnonymizeElectronicPharmacyStockRecord
  class Organizer
    include Interactor::Organizer

    organize AnonymizeElectronicPharmacyStockRecord::ReadSheet,
             AnonymizeElectronicPharmacyStockRecord::RemoveFields,
             AnonymizeElectronicPharmacyStockRecord::SaveSheet,
             AnonymizeElectronicPharmacyStockRecord::PruneTableFields
  end
end
