class AddRawErrorMessageToElectronicPharmacyStockRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :electronic_pharmacy_stock_records, :raw_error_message, :string
  end
end
