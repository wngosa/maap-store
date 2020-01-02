class AddS3FilePathToElectronicPharmacyStockRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :electronic_pharmacy_stock_records, :s3_file_path, :string
  end
end
