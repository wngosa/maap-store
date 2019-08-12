class AddPatientIdToLabRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :lab_records, :patient_id, :string
  end
end
