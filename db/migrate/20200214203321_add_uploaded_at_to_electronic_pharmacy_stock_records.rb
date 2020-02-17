class AddUploadedAtToElectronicPharmacyStockRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :electronic_pharmacy_stock_records, :uploaded_at, :datetime
  end
end
