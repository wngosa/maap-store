module AnonymizeLabRecordImport
  class ReadSheet
    include Interactor

    def call # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      begin
        context.sheet_path =
          ActiveStorage::Blob.service.send(
            :path_for,
            context.lab_record_import.sheet_file.key
          )
        context.sheet_type = :xlsx
        context.sheet_file =
          RubyXL::Parser.parse_buffer(File.open(context.sheet_path))
        context.current_sheet = context.sheet_file.worksheets[0]
      rescue NoMethodError, Zip::Error
        Rails.logger.info 'Falling back to spreadsheet gem'
        context.sheet_type = :xls
        context.sheet_file = Spreadsheet.open(context.sheet_path)
        context.current_sheet = context.sheet_file.worksheets[0]
      end
    rescue Ole::Storage::FormatError
      Rails.logger.info 'Falling back to csv'
      context.sheet_type = :csv
      context.sheet_file = CSV.read(context.sheet_path)
    end
  end
end
