require 'rails_helper'

RSpec.shared_examples 'purge rows file' do |params|
  let(:records) do
    {
      lab_record_import: create(:lab_record_import),
      electronic_pharmacy_stock_record: create(:electronic_pharmacy_stock_record)
    }
  end
  let(:record) { records[params[:record]] }
  let(:state_attribute) { params[:state_attribute] }

  before(:each) do
    record.rows_file.attach(
      io: File.open(EXAMPLE_XLS_PATH),
      filename: 'example_xls'
    )
  end

  it 'starts with rows_file attached' do
    expect(record.rows_file.attached?).to be true
  end

  it 'purges rows_file' do
    Sheets::PurgeRowsFile.call(
      record: record,
      state_attribute: state_attribute
    )
    expect(record.rows_file.attached?).to be false
  end

  it 'changes state to "obfuscated"' do
    previous_state = record[state_attribute]

    Sheets::PurgeRowsFile.call(
      record: record,
      state_attribute: state_attribute
    )

    expect(record[state_attribute]).not_to eq(previous_state)
    expect(record[state_attribute]).to eq('obfuscated')
  end
end

RSpec.describe 'PurgeRowsFile' do
  describe 'LabRecordImport' do
    include_examples 'purge rows file', record: :lab_record_import, state_attribute: :patient_id_state
  end

  describe 'Electronic Pharmacy Stock Records' do
    include_examples 'purge rows file',
                     record: :electronic_pharmacy_stock_record,
                     state_attribute: :obfuscation_state
  end
end
