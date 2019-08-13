module AnonymizeLabRecordImport
  class ReadSheet
    include Interactor

    def call # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      context.sheet_path =
        ActiveStorage::Blob.service.send(
          :path_for,
          context.lab_record.sheet_file.key
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
  end
end
