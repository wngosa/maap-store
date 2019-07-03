FactoryBot.define do
  factory :specimen_source do
    name { FFaker::HealthcareIpsum.word }
  end
end
