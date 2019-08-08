require 'rubyXL/convenience_methods/cell'

module AnonymizeLabRecordFile
  class RemoveFields
    include Interactor

    OFFUSCATED_TEXT = 'Not available'.freeze
    INVALID_DATE = 'Invalid date format'.freeze
    FORMATS = {
      DDMMYYYY: '%d%m%Y',
      MMDDYYYY: '%m%d%Y',
      DDMMMYYYY: '%d%b%Y'
    }.freeze

    def call # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      (first_row..last_row).to_a.each do |row_number|
        # TODO: Relation Patient ID
        columns_to_offuscate.each do |column_number|
          update_cell(row_number - 1, column_number, OFFUSCATED_TEXT)
        end

        date_columns.each do |column|
          date_format, column_number = column
          parsed_date =
            parse_date(read_cell(row_number, column_number), date_format)
          if parsed_date
            update_cell(row_number - 1, column_number,
                        parsed_date.beginning_of_month.strftime('%d/%m/%Y'))
          else
            update_cell(row_number - 1, column_number, INVALID_DATE)
          end
        end
      end
    end

    private

    def parse_date(date, format)
      Date.strptime(date, FORMATS[format.to_sym])
    rescue ArgumentError, TypeError
      nil
    end

    def read_cell(row, col)
      if context.sheet_type == :xlsx
        context.current_sheet[row][col].value
      else
        context.current_sheet[row, col]
      end
    end

    def update_cell(row, col, content)
      if context.sheet_type == :xlsx
        context.current_sheet[row][col].change_contents(
          content
        )
      else
        context.current_sheet[row, col] = content
      end
    end

    def date_columns
      @date_columns ||=
        context.lab_record.date.each_with_index.select { |c| c[0] }
    end

    def columns_to_offuscate
      @columns_to_offuscate ||=
        context.lab_record.phi.each_with_index.select { |c| c[0] }.map(&:last)
    end

    def first_row
      @first_row ||= context.lab_record.data_rows_from
    end

    def last_row
      @last_row ||= context.lab_record.data_rows_to
    end
  end
end
