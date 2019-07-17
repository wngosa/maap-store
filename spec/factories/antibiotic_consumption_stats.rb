FactoryBot.define do
  factory :antibiotic_consumption_stat do
    antibiotic
    issued { Faker::Boolean.boolean }
    quantity { Faker::Number.number(3) }
    balance { Faker::Number.number(3) }
    recipient_unit { FFaker::HealthcareIpsum.word }
    recipient_facility { FFaker::HealthcareIpsum.word }
    date { "2019-07-11 10:53:22" }
  end
end
