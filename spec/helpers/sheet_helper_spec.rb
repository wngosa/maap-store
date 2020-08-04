require 'rails_helper'

RSpec.shared_examples "sheet read/update" do |sheet|
  let(:sheet) { sheet }

  it "reads sheet at row and column" do
    expect(sheet.read(0,0)).to eq('first')
    expect(sheet.read(0,1)).to eq('second')
    expect(sheet.read(0,2)).to eq('third')
    expect(sheet.read(1,0)).to eq('a')
    expect(sheet.read(1,1)).to eq('b')
    expect(sheet.read(1,2)).to eq('c')
  end

  it "updates sheet at row and column" do
    for i in 0..1
      for j in 0..2
        sheet.update_cell(i, j, sheet.read(i,j)*2)
      end
    end
    
    expect(sheet.read(0,0)).to eq('firstfirst')
    expect(sheet.read(0,1)).to eq('secondsecond')
    expect(sheet.read(0,2)).to eq('thirdthird')
    expect(sheet.read(1,0)).to eq('aa')
    expect(sheet.read(1,1)).to eq('bb')
    expect(sheet.read(1,2)).to eq('cc')
  end
end

RSpec.describe "SheetHelper", type: :helper do
  describe SheetHelper::CSV do
    csv_sheet = SheetHelper::CSV.new([['first','second','third'],['a', 'b', 'c']])
    include_examples "sheet read/update", csv_sheet
  end

  describe SheetHelper::XLS do
    worksheet = Spreadsheet::Workbook.new.create_worksheet
    worksheet.row(0).concat %w{first second third}
    worksheet.row(1).concat %w{a b c}
    xls_sheet = SheetHelper::XLS.new(worksheet)
    include_examples "sheet read/update", xls_sheet
  end
end
