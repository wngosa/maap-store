FactoryBot.define do
  factory :clinical_service do
    name { FFaker::HealthcareIpsum.word }
  end
end
