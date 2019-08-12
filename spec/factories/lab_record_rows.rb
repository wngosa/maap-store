FactoryBot.define do
  factory :lab_record_row do
    content { '' }
    lab_record_import { nil }
    patient_id_state { 'MyString' }
    row { 1 }
  end
end
