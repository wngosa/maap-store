class AddStateToLabRecordImport < ActiveRecord::Migration[5.2]
  def change
    add_column :lab_record_imports, :patient_id_state, :string, default: 'pending'
  end
end
