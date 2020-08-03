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

def lri_with_lab_records(count=5)
  FactoryBot.create(:lab_record_import) do |lri|
    FactoryBot.create_list(:lab_record, count, lab_record_import: lri)
  end
end
