class AddPatientIdStateToPatients < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :patient_id_state, :string, default: 'pending'
  end
end
