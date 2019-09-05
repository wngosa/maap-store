FactoryBot.define do
  factory :site do
    name { FFaker::CompanyIT.prefix }
    address { FFaker::Address.street_address }
    ownership { Site::OWNERSHIPS.sample }
    has_pharmacy { FFaker::Boolean.maybe }
    has_hospital { FFaker::Boolean.maybe }
    has_laboratory { FFaker::Boolean.maybe }
  end
end
