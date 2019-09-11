FactoryBot.define do
  factory :electronic_pharmacy_stock_record do
    header_row { 1 }
    data_rows_from { 1 }
    data_rows_to { 1 }
    rows { '' }
    columns { '' }
    phi { '' }
    date { '' }
    site { nil }
    patient_id_state { 1 }
  end
end
