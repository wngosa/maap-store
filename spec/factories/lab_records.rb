FactoryBot.define do
  factory :lab_record do
    header_row { 1 }
    data_rows_from { 1 }
    data_rows_to { 1 }
    rows { '' }
    columns { '' }
    patient_or_lab_record_id { '' }
    phi { '' }
    date { '' }
  end
end
