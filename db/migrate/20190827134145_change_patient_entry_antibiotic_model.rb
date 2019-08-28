class ChangePatientEntryAntibioticModel < ActiveRecord::Migration[5.2]
  def change
    remove_column :patient_entries, :antibiotic_consumption
    add_column :patient_entries, :antibiotic_when, :string
  end
end
