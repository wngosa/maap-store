require 'rubyXL/convenience_methods/cell'

module Sheets
  class ObfuscateFields
    include Interactor

    OBFUSCATED_TEXT = 'Not available'.freeze
    INVALID_DATE = 'Invalid date format'.freeze

    def call # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      Rails.logger.info "Fields obfuscation in file '#{context.record.file_name}' started"

      sheet_file = nil
      if context.sheet_type == :csv
        sheet_file = SheetHelper::CSV.new(context.sheet_file)
      elsif context.sheet_type == :xls
        sheet_file = SheetHelper::XLS.new(context.sheet_file)
      else
        raise StandardError, 'Only XLS and CSV format supported'
      end

      (first_row..last_row).to_a.each do |row_number|
        columns_to_obfuscate.each do |column_number|
          sheet_file.update_cell(row_number - 1, column_number, OBFUSCATED_TEXT)
        end

        date_columns.each do |column|
          date_format, column_number = column
          parsed_date =
            DateHelper.parse_date(
              sheet_file.read(row_number - 1, column_number),
              date_format
            )
          if parsed_date
            sheet_file.update_cell(
              row_number - 1,
              column_number,
              parsed_date.beginning_of_month.strftime(
                DateHelper::FORMATS_DICTIONARY[date_format.to_sym]
              )
            )
          else
            sheet_file.update_cell(row_number - 1, column_number, INVALID_DATE)
          end
        end
      end

      Rails.logger.info "Fields obfuscation in file '#{context.record.file_name}' finished"
    end

    private

    def date_columns
      @date_columns ||=
        context.record.date.each_with_index.select { |c| c[0] }
    end

    def columns_to_obfuscate # rubocop:disable Metrics/AbcSize
      return @columns_to_obfuscate if @columns_to_obfuscate

      if context.record.phi.is_a? Array
        return @columns_to_obfuscate =
                 context.record.phi.each_with_index.select { |c| c[0] }.map(&:last)
      end
      @columns_to_obfuscate =
        context.record.phi.values.each_with_index.select { |c| c[0] }.map(&:last)
    end

    def first_row
      @first_row ||= context.record.data_rows_from
    end

    def last_row
      @last_row ||= context.record.data_rows_to
    end
  end
end
