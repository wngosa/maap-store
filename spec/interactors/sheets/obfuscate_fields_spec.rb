require 'rails_helper'

RSpec.shared_examples "obfuscate fields in file" do |params|
  let(:lab_record_import) do
    create(
      :lab_record_import,
      header_row: 1,
      data_rows_from: 2,
      data_rows_to: 3,
      phi: "[false,false,true,true,false]",
      date: "[null,null,null,null,\"MM-DD-YYYY\"]"
    )
  end
  let(:sheet_type) { params[:sheet_type] }
  let(:sheet) { params[:sheet] }

  it "obfuscates phi and only phi fields" do
    Sheets::ObfuscateFields.call(
      record: lab_record_import,
      sheet_type: sheet_type,
      sheet_file: sheet.sheet_file
    )
  
    expect(sheet.read(1,1)).to eq('female')
    expect(sheet.read(1,2)).to eq('Not available')
    expect(sheet.read(1,3)).to eq('Not available')
    expect(sheet.read(2,1)).to eq('male')
    expect(sheet.read(2,2)).to eq('Not available')
    expect(sheet.read(2,3)).to eq('Not available')
  end
  
  it "obfuscates dates by mapping them to the beginning of the month" do
    Sheets::ObfuscateFields.call(
      record: lab_record_import,
      sheet_type: sheet_type,
      sheet_file: sheet.sheet_file
    )
  
    expect(sheet.read(1,4)).to eq('08-01-2019')
    expect(sheet.read(2,4)).to eq('04-01-2020')
  end

  it "replaces dates with 'Invalid date format' on incorrect date format" do
    sheet.update_cell(1,4,'08/01/2019')
    sheet.update_cell(2,4,'04/01/2020')

    Sheets::ObfuscateFields.call(
      record: lab_record_import,
      sheet_type: sheet_type,
      sheet_file: sheet.sheet_file
    )
  
    expect(sheet.read(1,4)).to eq('Invalid date format')
    expect(sheet.read(2,4)).to eq('Invalid date format')
  end
end

RSpec.describe Sheets::ObfuscateFields, type: :interactor do
  describe "CSV" do
    include_examples "obfuscate fields in file", {
      :sheet_type => :csv,
      :sheet => SheetHelper::CSV.new([
        ['patientId', 'sex', 'age', 'birthyear', 'report date'],
        ['Jane Doe', 'female', '27', '1992', '08-05-2019'],
        ['John Smith', 'male', '20', '2000', '04-20-2020']
      ])
    }
  end

  describe "XLS" do
    sheet = Spreadsheet::Workbook.new.create_worksheet
    sheet.row(0).concat ['patientId', 'sex', 'age', 'birthyear', 'report date']
    sheet.row(1).concat ['Jane Doe', 'female', '27', '1992', '08-05-2019']
    sheet.row(2).concat ['John Smith', 'male', '20', '2000', '04-20-2020']

    include_examples "obfuscate fields in file", {
      :sheet_type => :xls,
      :sheet => SheetHelper::XLS.new(sheet)
    }
  end

  describe "Invalid Format" do
    it "raises error when format is neither CSV nor XLS" do
      expect {
        Sheets::ObfuscateFields.call(
          record: create(:lab_record_import), 
          sheet_type: :xlsx, 
          sheet_file: {}
        )
      }.to raise_error("Only XLS and CSV format supported")
    end
  end
end
