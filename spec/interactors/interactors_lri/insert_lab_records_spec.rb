require 'rails_helper'

RSpec.describe InteractorsLRI::InsertLabRecords, type: :interactor do
  it "creates lab records when rows_file has rows" do
    l = create(:lab_record_import, patient_or_lab_record_id: ["patientId","labRecordId"].to_json) 
    rows = [
      {
        "content" => [{"w" => "James P."}, {"w" => "Foo Hospital"}]
      },
      {
        "content" => [{"w" => "Marry D."}, {"w" => "Bar Laboratory"}]
      }
    ]

    Tempfile.open('rows_file.json') do |rows_file|
      rows_file.write(rows.to_json)
      rows_file.rewind
      l.rows_file.attach(io: rows_file, filename: "rows_file.json", content_type: "application/json")

      InteractorsLRI::InsertLabRecords.call(record: l)

      rows.zip(LabRecord.all) do |row, lab_record|
        expect(lab_record.patient_id).to eq(row["content"][l.patient_id_index]["w"])
        expect(lab_record.patient_id_state).to eq("pending")
      end
    end
  end

  it "doesn't create lab records if rows_file has no rows" do 
    l = create(:lab_record_import, patient_or_lab_record_id: ["patientId","labRecordId"].to_json) 
    rows = []
    Tempfile.open('rows_file.json') do |rows_file|
      rows_file.write(rows.to_json)
      rows_file.rewind
      l.rows_file.attach(io: rows_file, filename: "rows_file.json", content_type: "application/json")

      InteractorsLRI::InsertLabRecords.call(record: l)

      expect(LabRecord.count).to be_zero
    end
  end

  it "doesn't create lab records when should skip obfuscation" do
    s = create(:site)
    lab_record_import = create(:lab_record_import, site: s, patient_or_lab_record_id: [].to_json)

    rows = [
      {
        "content" => [{"w" => "James P."}, {"w" => "Foo Hospital"}]
      },
      {
        "content" => [{"w" => "Marry D."}, {"w" => "Bar Laboratory"}]
      }
    ]

    Tempfile.open('rows_file.json') do |rows_file|
      rows_file.write(rows.to_json)
      rows_file.rewind
      lab_record_import.rows_file.attach(io: rows_file, filename: "rows_file.json", content_type: "application/json")

      InteractorsLRI::InsertLabRecords.call(record: lab_record_import)

      expect(lab_record_import.skip_obfuscation?).to be true
      expect(LabRecord.count).to be_zero
    end
  end
end
