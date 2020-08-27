FactoryBot.define do
  factory :electronic_pharmacy_stock_record do
    header_row { 1 }
    data_rows_from { 1 }
    data_rows_to { 1 }
    columns { '' }
    phi { '' }
    date { '' }
    obfuscation_state { 0 }
    site
  end
end
