FactoryBot.define do
  factory :lab_record_import do
    header_row { 1 }
    data_rows_from { 2 }
    data_rows_to { 6 }
    patient_or_lab_record_id { "[\"patientId\",\"labRecordId\",null,null,null]" }
    phi { "[false,false,true,true,false]" }
    site
  end
end
