require 'rubyXL/convenience_methods/cell'

module Sheets
  class ObfuscateFields
    include Interactor

    OBFUSCATED_TEXT = 'Not available'.freeze
    INVALID_DATE = 'Invalid date format'.freeze
    FORMATS = {
      'DD/MM/YYYY': '%d/%m/%Y',
      'DD/MM/YY': '%d/%m/%y',
      'MM/DD/YYYY': '%m/%d/%Y',
      'MM/DD/YY': '%m/%d/%y',
      DDMMMYYYY: '%d%b%Y',
      DDMMMYY: '%d%b%y',
      'MM-DD-YYYY': '%m-%d-%Y',
      'MM-DD-YY': '%m-%d-%y',
      'DD-MM-YYYY': '%d-%m-%Y',
      'DD-MM-YY': '%d-%m-%y',
      'YYYY-MM-DD': '%Y-%m-%d'
    }.freeze

    def call # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      Rails.logger.info "Fields obfuscation in file '#{context.record.file_name}' started"

      (first_row..last_row).to_a.each do |row_number|
        columns_to_obfuscate.each do |column_number|
          update_cell(row_number - 1, column_number, OBFUSCATED_TEXT)
        end

        date_columns.each do |column|
          date_format, column_number = column
          parsed_date =
            parse_date(read_cell(row_number - 1, column_number), date_format)
          if parsed_date
            update_cell(row_number - 1, column_number,
                        parsed_date.beginning_of_month.strftime(FORMATS[date_format.to_sym]))
          else
            update_cell(row_number - 1, column_number, INVALID_DATE)
          end
        end
      end

      Rails.logger.info "Fields obfuscation in file '#{context.record.file_name}' finished"
    end

    private

    def parse_date(date, format)
      return date if date.is_a?(DateTime) || date.is_a?(Date)

      Date.strptime(date, FORMATS[format.to_sym])
    rescue ArgumentError, TypeError
      nil
    end

    def read_cell(row, col)
      return read_xls(row, col) if context.sheet_type == :xls

      read_csv(row, col)
    end

    def read_csv(row, col)
      context.sheet_file[row][col]
    end

    def read_xls(row, col)
      context.sheet_file[row, col]
    end

    def update_cell(row, col, content)
      return update_cell_xls(row, col, content) if context.sheet_type == :xls

      update_cell_csv(row, col, content)
    end

    def update_cell_csv(row, col, content)
      context.sheet_file[row][col] = content
    end

    def update_cell_xls(row, col, content)
      context.sheet_file[row, col] = content
    end

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
