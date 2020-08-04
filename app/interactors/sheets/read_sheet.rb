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
        file_type = `file --b --mime-type '#{context.sheet_path}'`.strip
        Rails.logger.info file_type
        raise Zip::Error unless file_type == 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' # rubocop:disable Metrics/LineLength

        Rails.logger.info 'XLSX opened'
        context.sheet_type = :xlsx

        context.record[context.state_attribute] = :error
        context.record.error_message = 'XLSX files not supported'
        context.record.save!
        context.fail!
      rescue NoMethodError, Zip::Error
        Rails.logger.info 'Falling back to spreadsheet gem'
        context.sheet_type = :xls
        context.sheet_file = Spreadsheet.open(context.sheet_path).worksheets[0]
      end
    rescue Ole::Storage::FormatError => e
      Rails.logger.info e
      Rails.logger.info 'Falling back to csv'
      context.sheet_type = :csv
      context.sheet_file = CSV.read(context.sheet_path)
    end
  end
end
