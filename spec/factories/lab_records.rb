FactoryBot.define do
  factory :lab_record do
    patient_id_state { 'pending' }
    row { 0 }
    patient_id { FFaker::Name.name }
    lab_record_import
    site
  end
end
