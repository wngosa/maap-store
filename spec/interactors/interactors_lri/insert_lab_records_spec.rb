require 'rails_helper'

RSpec.describe InteractorsLRI::InsertLabRecords, type: :interactor do
  include AttachmentHelpers
  it 'creates lab records when rows_file has rows' do
    l = create(:lab_record_import, patient_or_lab_record_id: %w[patientId labRecordId].to_json)
    rows = [
      {
        'content' => [{ 'w' => 'James P.' }, { 'w' => 'Foo Hospital' }]
      },
      {
        'content' => [{ 'w' => 'Marry D.' }, { 'w' => 'Bar Laboratory' }]
      }
    ]

    with_rows_file_attached(l, rows) do
      InteractorsLRI::InsertLabRecords.call(record: l)

      rows.zip(LabRecord.all) do |row, lab_record|
        expect(lab_record.patient_id).to eq(row['content'][l.patient_id_index]['w'])
        expect(lab_record.patient_id_state).to eq('pending')
      end
    end
  end

  it "doesn't create lab records if rows_file has no rows" do
    l = create(:lab_record_import, patient_or_lab_record_id: %w[patientId labRecordId].to_json)
    rows = []

    with_rows_file_attached(l, rows) do
      InteractorsLRI::InsertLabRecords.call(record: l)
      expect(LabRecord.count).to be_zero
    end
  end

  it "doesn't create lab records when should skip obfuscation" do
    l = create(:lab_record_import, patient_or_lab_record_id: [].to_json)

    rows = [
      {
        'content' => [{ 'w' => 'James P.' }, { 'w' => 'Foo Hospital' }]
      },
      {
        'content' => [{ 'w' => 'Marry D.' }, { 'w' => 'Bar Laboratory' }]
      }
    ]

    with_rows_file_attached(l, rows) do
      InteractorsLRI::InsertLabRecords.call(record: l)

      expect(l.skip_obfuscation?).to be true
      expect(LabRecord.count).to be_zero
    end
  end
end
