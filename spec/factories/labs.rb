FactoryBot.define do
  factory :lab do
    name { FFaker::CompanyIT.prefix }
    address { FFaker::Address.street_address }
    location { "#{FFaker::Geolocation.lat}, #{FFaker::Geolocation.lng}" }
    ownership { Lab::OWNERSHIPS.sample }
    has_farmacy { FFaker::Boolean.maybe }
    identified_patients { FFaker::Boolean.maybe }
    permanently_identified_patients { FFaker::Boolean.maybe }
  end
end
