FactoryBot.define do
  factory :patient_location do
    name { FFaker::HealthcareIpsum.word }
  end
end
