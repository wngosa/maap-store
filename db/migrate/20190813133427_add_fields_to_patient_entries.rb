class AddFieldsToPatientEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :patient_entries, :location, :string


    add_column :patient_entries, :department, :string
    add_column :patient_entries, :admission_date, :string
    add_column :patient_entries, :discharge_date, :string
    add_column :patient_entries, :weight, :string
    add_column :patient_entries, :height, :string
    add_column :patient_entries, :pregnancy_status, :boolean
    add_column :patient_entries, :premature_birth, :boolean
    add_column :patient_entries, :chief_complaint, :string
    add_column :patient_entries, :patient_transferred, :boolean
    add_column :patient_entries, :primary_diagnosis, :string
    add_column :patient_entries, :primary_diagnosis_icd_code, :string
    add_column :patient_entries, :acute_myocardial_infarction, :boolean
    add_column :patient_entries, :chf, :boolean
    add_column :patient_entries, :not_mentioned, :boolean
    add_column :patient_entries, :other, :boolean
    add_column :patient_entries, :antibiotics_prescribed, :boolean
    add_column :patient_entries, :antibiotic, :string
    add_column :patient_entries, :antibiotic_consumption, :string
    add_column :patient_entries, :patient_was_on_an_indwelling_medical_device, :boolean
    add_column :patient_entries, :medical_device, :string
    add_column :patient_entries, :infection_acquisition, :string
    add_column :patient_entries, :discharge_diagnostic, :string
    add_column :patient_entries, :discharge_diagnostic_icd_code, :string
    add_column :patient_entries, :patient_outcome_at_discharge, :string
  end
end
