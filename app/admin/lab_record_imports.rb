ActiveAdmin.register LabRecordImport do
  index :download_links => false do
    column :id
    column :file do |lab_record|
      next 'Error' if lab_record.error?
      next 'Obfuscating' unless lab_record.obfuscated?
      link_to 'Download',
              rails_blob_path(lab_record.sheet_file, disposition: 'attachment'),
              download: true
    end
    column :site
    column "Site Id", :site_id
    column :header_row
    column :data_rows_from
    column :data_rows_to
    column :obfuscation_state
    column :error_message
  end
end
