require 'rails_helper'

RSpec.describe "ReadSheet" do
  let(:lab_record_import) { create(:lab_record_import) }
  it "reads file in xls format" do
    lab_record_import.sheet_file.attach(
      io: File.open(EXAMPLE_XLS_PATH), 
      filename: 'example_xls'
    )

    context = Sheets::ReadSheet.call(record: lab_record_import, state_attribute: :patient_id_state) 
    sheet_file = SheetHelper::XLS.new(context.sheet_file)
    
    expect(context.sheet_type).to eq(:xls)
    expect(sheet_file.read(0,1)).to eq('First Name')
    expect(sheet_file.read(0,2)).to eq('Last Name')
    expect(sheet_file.read(0,3)).to eq('Gender')
    expect(sheet_file.read(0,4)).to eq('Country')
    expect(sheet_file.read(0,5)).to eq('Age')
    expect(sheet_file.read(0,6)).to eq('Date')
    expect(sheet_file.read(0,7)).to eq('Id')
  end

  it "reads file in csv format" do
    lab_record_import.sheet_file.attach(
      io: File.open(EXAMPLE_CSV_PATH), 
      filename: 'example_csv'
    )

    context = Sheets::ReadSheet.call(record: lab_record_import, state_attribute: :patient_id_state) 
    sheet_file = SheetHelper::CSV.new(context.sheet_file)
    
    expect(context.sheet_type).to eq(:csv)
    expect(sheet_file.read(0,0)).to eq('first')
    expect(sheet_file.read(0,1)).to eq('second')
    expect(sheet_file.read(0,2)).to eq('third')
    expect(sheet_file.read(1,0)).to eq('one')
    expect(sheet_file.read(1,1)).to eq('two')
    expect(sheet_file.read(1,2)).to eq('three')
  end

  it "raises error when reading file with xlsx format" do
    lab_record_import.sheet_file.attach(
      io: File.open(EXAMPLE_XLSX_PATH), 
      filename: 'example_xlsx',
      content_type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )

    expect { 
      Sheets::ReadSheet.call(
        record: lab_record_import, 
        state_attribute: :patient_id_state
      )
    }.to raise_error(StandardError)
  end
end
