FactoryBot.define do
  factory :patient do
    gender { 'MyString' }
    year_of_birth { 1 }
    level_of_education { 'MyString' }
    patient_id { 'MyString' }
    site
  end
end
