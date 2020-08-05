require 'rails_helper'

RSpec.shared_examples "hash patient ids in file" do |params|
  let(:lab_record_import) do
    create(
      :lab_record_import, 
      header_row: 1, 
      data_rows_from: 2, 
      patient_or_lab_record_id: "[null,\"patientId\",null]"
    )
  end
  let(:sheet_type) { params[:sheet_type] }
  let(:no_patient_id_header) { params[:no_patient_id_header] }
  let(:hashed_patients) { params[:hashed_patients] }

  it "names 'Patient Id' column when it's empty" do
    sheet_file = no_patient_id_header

    InteractorsLRI::HashPatientsInFile.call(
      record: lab_record_import, 
      sheet_type: sheet_type, 
      sheet_file: no_patient_id_header.sheet_file
    )

    expect(sheet_file.read(0,1)).to eq('Patient Id')
  end

  it "overwrites cells containing patients ids" do
    sheet_file = hashed_patients

    lab_record_1 = create(
      :lab_record, 
      lab_record_import: lab_record_import, 
      patient_id: "hashed jane", 
      patient_id_state: "obfuscated", 
      row: 0
    )
    lab_record_2 = create(
      :lab_record, 
      lab_record_import: lab_record_import, 
      patient_id: "hashed john", 
      patient_id_state: "obfuscated", 
      row: 1
    )

    InteractorsLRI::HashPatientsInFile.call(
      record: lab_record_import, 
      sheet_type: sheet_type, 
      sheet_file: hashed_patients.sheet_file
    ) 

    expect(sheet_file.read(1,1)).to eq('hashed jane')
    expect(sheet_file.read(2,1)).to eq('hashed john')
  end
end


RSpec.describe InteractorsLRI::HashPatientsInFile, type: :interactor do
  describe "CSV" do
    include_examples "hash patient ids in file", {
      :sheet_type => :csv,
      :no_patient_id_header => SheetHelper::CSV.new([['first', '', 'third'],['a', 'a patient', 'c']]),
      :hashed_patients => SheetHelper::CSV.new([
        ['lab', 'Patient Id', 'sick'],
        ['Mbabane Lab', 'Jane Doe', 23], 
        ['Mbabane Lab', 'John Smith', 25]
      ])
    }
  end

  describe "XLS" do
    spreadsheet = Spreadsheet::Workbook.new

    worksheet_no_patient_id_header = spreadsheet.create_worksheet
    worksheet_no_patient_id_header.row(0).concat ['first', '', 'third']
    worksheet_no_patient_id_header.row(1).concat ['a', 'a patient', 'c']

    worksheet_hashed_patients = spreadsheet.create_worksheet
    worksheet_hashed_patients.row(0).concat ['lab', 'Patient Id', 'sick']
    worksheet_hashed_patients.row(1).concat ['Mbabane Lab', 'Jane Doe', 23]
    worksheet_hashed_patients.row(2).concat ['Mbabane Lab', 'John Smith', 25]

    include_examples "hash patient ids in file", {
      :sheet_type => :xls,
      :no_patient_id_header => SheetHelper::XLS.new(worksheet_no_patient_id_header),
      :hashed_patients => SheetHelper::XLS.new(worksheet_hashed_patients)
    }
  end

  describe "Invalid Format" do
    it "raises error when format is neither CSV nor XLS" do
      expect {
        InteractorsLRI::HashPatientsInFile.call(
          record: create(:lab_record_import), 
          sheet_type: :xlsx, 
          sheet_file: {}
        )
      }.to raise_error("Only XLS and CSV format supported")
    end
  end
end
