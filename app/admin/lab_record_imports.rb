ActiveAdmin.register LabRecordImport do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    column :id
    column :file do |lab_record|
      link_to 'Download',
              rails_blob_path(lab_record.sheet_file, disposition: 'attachment'),
              download: true
    end
    column :header_row
    column :data_rows_from
    column :data_rows_to
  end
end
