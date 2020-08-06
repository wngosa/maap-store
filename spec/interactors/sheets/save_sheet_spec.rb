require 'rails_helper'

RSpec.describe 'SaveSheet' do
  describe 'XLS' do
    let(:site) { create(:site) }
    let(:lab_record_import) do
      lab_record_import = create(:lab_record_import, file_name: 'example.xls', site: site)
      lab_record_import.sheet_file.attach(
        io: File.open(EXAMPLE_XLS_PATH),
        filename: 'example.xls'
      )
      lab_record_import
    end

    let(:sheet_with_changes) do
      sheet_with_changes = SheetHelper::XLS.new(
        Spreadsheet.open(EXAMPLE_XLS_PATH).worksheets[0]
      )
      sheet_with_changes.update_cell(0, 0, 'Hi from SaveSheet spec')
      sheet_with_changes
    end

    it 'reads file in xls format' do
      sheet_path = ActiveStorage::Blob.service.send(
        :path_for,
        lab_record_import.sheet_file.key
      )

      Sheets::SaveSheet.call(
        record: lab_record_import,
        sheet_path: sheet_path,
        sheet_type: :xls,
        sheet_file: sheet_with_changes.sheet_file
      )

      modified_sheet = SheetHelper::XLS.new(
        Spreadsheet.open(
          ActiveStorage::Blob.service.send(
            :path_for,
            lab_record_import.sheet_file.key
          )
        ).worksheets[0]
      )

      expect(modified_sheet.read(0, 0)).to eq('Hi from SaveSheet spec')
    end

    it 'saves file with proper name' do
      sheet_path = ActiveStorage::Blob.service.send(
        :path_for,
        lab_record_import.sheet_file.key
      )
      file_id = lab_record_import.sheet_file.id.to_s

      Sheets::SaveSheet.call(
        record: lab_record_import,
        sheet_path: sheet_path,
        sheet_type: :xls,
        sheet_file: sheet_with_changes.sheet_file
      )

      expect(
        lab_record_import.sheet_file.filename.to_s
      ).to eq("#{file_id}-example-#{site.id}.xls")
    end
  end

  describe 'CSV' do
    let(:site) { create(:site) }
    let(:lab_record_import) do
      lab_record_import = create(:lab_record_import, file_name: 'example.csv', site: site)
      lab_record_import.sheet_file.attach(
        io: File.open(EXAMPLE_CSV_PATH),
        filename: 'example.csv'
      )
      lab_record_import
    end

    let(:sheet_with_changes) do
      sheet_with_changes = SheetHelper::CSV.new(
        CSV.read(EXAMPLE_CSV_PATH)
      )
      sheet_with_changes.update_cell(0, 0, 'Hi from SaveSheet spec')
      sheet_with_changes
    end

    it 'reads file in xls format' do
      sheet_path = ActiveStorage::Blob.service.send(
        :path_for,
        lab_record_import.sheet_file.key
      )

      Sheets::SaveSheet.call(
        record: lab_record_import,
        sheet_path: sheet_path,
        sheet_file: sheet_with_changes.sheet_file
      )

      modified_sheet = SheetHelper::CSV.new(
        CSV.read(
          ActiveStorage::Blob.service.send(
            :path_for,
            lab_record_import.sheet_file.key
          )
        )
      )

      expect(modified_sheet.read(0, 0)).to eq('Hi from SaveSheet spec')
    end

    it 'saves file with proper name' do
      sheet_path = ActiveStorage::Blob.service.send(
        :path_for,
        lab_record_import.sheet_file.key
      )
      file_id = lab_record_import.sheet_file.id.to_s

      Sheets::SaveSheet.call(
        record: lab_record_import,
        sheet_path: sheet_path,
        sheet_type: :csv,
        sheet_file: sheet_with_changes.sheet_file
      )

      expect(
        lab_record_import.sheet_file.filename.to_s
      ).to eq("#{file_id}-example-#{site.id}.csv")
    end
  end
end
