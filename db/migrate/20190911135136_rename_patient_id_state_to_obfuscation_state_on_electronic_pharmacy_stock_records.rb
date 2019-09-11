class RenamePatientIdStateToObfuscationStateOnElectronicPharmacyStockRecords < ActiveRecord::Migration[5.2]
  def change
    rename_column :electronic_pharmacy_stock_records, :patient_id_state, :obfuscation_state
  end
end
