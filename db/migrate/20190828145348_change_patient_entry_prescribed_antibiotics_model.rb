class ChangePatientEntryPrescribedAntibioticsModel < ActiveRecord::Migration[5.2]
  def change
    remove_column :patient_entries, :antibiotic
    add_column :patient_entries, :prescribed_antibiotics_list, :string
  end
end
