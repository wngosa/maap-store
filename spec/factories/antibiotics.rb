FactoryBot.define do
  factory :antibiotic do
    name { FFaker::HealthcareIpsum.word }
    strength_value { Faker::Number.number(4) }
    strength_unit { FFaker::UnitEnglish.mass_abbr }
    form { FFaker::HealthcareIpsum.word }
    pack_size { Faker::Number.number(4) }
    brand { FFaker::Product.brand }
  end
end
