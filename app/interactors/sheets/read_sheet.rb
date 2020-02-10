module Sheets
  class ReadSheet
    include Interactor

    def call # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      Rails.logger.info 'Starting reading file'
      begin
        context.sheet_path =
          ActiveStorage::Blob.service.send(
            :path_for,
            context.record.sheet_file.key
          )
        context.sheet_type = :xlsx
        context.sheet_file =
          RubyXL::Parser.parse(context.sheet_path)
        context.current_sheet = context.sheet_file.worksheets[0]
        context.record[context.state_attribute] = :error
        context.record.error_message = 'XLSX files not supported'
        context.save!
        context.fail!
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
