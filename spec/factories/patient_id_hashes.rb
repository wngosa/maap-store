FactoryBot.define do
  factory :patient_id_hash do
    patient_id { 'MyString' }
    hashed_value { 'MyString' }
    site
  end
end
