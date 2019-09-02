ActiveAdmin.register LabRecord do
  actions :show, :index

  index do
    selectable_column
    column :id
    column :site
    column :lab_record_import
    column :row
    column :created_at
    column :patient_id

    actions
  end
end
