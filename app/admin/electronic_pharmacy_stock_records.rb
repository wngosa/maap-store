ActiveAdmin.register ElectronicPharmacyStockRecord do
  actions :index, :show

  index :download_links => false do
    column :id
    column :file do |electronic_pharmacy_stock_record|
      next 'Error' if electronic_pharmacy_stock_record.error?
      next 'Obfuscating' unless electronic_pharmacy_stock_record.obfuscated?
      link_to 'Download',
              rails_blob_path(electronic_pharmacy_stock_record.sheet_file, disposition: 'attachment'),
              download: true
    end
    column :site
    column "Site Id", :site_id
    column :header_row
    column :data_rows_from
    column :data_rows_to
    column :obfuscation_state
    column :error_message
    column :uploaded_at
  end
end
