class RemoveHardcodedComorbiditiesFromPatientEntries < ActiveRecord::Migration[5.2]
  def change
    remove_column :patient_entries, :acute_myocardial_infarction
    remove_column :patient_entries, :chf
    remove_column :patient_entries, :not_mentioned
    remove_column :patient_entries, :other
  end
end
