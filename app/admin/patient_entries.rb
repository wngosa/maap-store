ActiveAdmin.register PatientEntry do
  actions :index, :show

  csv do
    column :id
    column :patient_id
    column :department
    column :weight
    column :height
    column :chief_complaint
    column :patient_transferred
    column :primary_diagnosis
    column :primary_diagnosis_icd_code
    column :antibiotics_prescribed
    column :patient_was_on_an_indwelling_medical_device
    column :medical_device
    column :infection_acquisition
    column :discharge_diagnostic
    column :discharge_diagnostic_icd_code
    column :patient_outcome_at_discharge
    column :stay_timespan
    column :patient_location_id
    column :pregnancy_status
    column :premature_birth
    column :comorbidities
    column :antibiotic_when
    column :prescribed_antibiotics_list
    column :patient_location_id
    column :created_at
    column :updated_at
  end
end
