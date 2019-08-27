FactoryBot.define do
  factory :site do
    name { FFaker::CompanyIT.prefix }
    address { FFaker::Address.street_address }
    location { "#{FFaker::Geolocation.lat}, #{FFaker::Geolocation.lng}" }
    ownership { Site::OWNERSHIPS.sample }
    has_farmacy { FFaker::Boolean.maybe }
    has_hospital { FFaker::Boolean.maybe }
    has_laboratory { FFaker::Boolean.maybe }
  end
end
