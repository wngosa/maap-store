require 'rubyXL/convenience_methods/cell'

module AnonymizeLabRecordImport
  class ObfuscatePatientIds
    include Interactor

    def call # rubocop:disable Metrics/AbcSize
      return unless context.patient_ids

      context.lab_record.lab_records.obfuscated.order(row: :asc).each do |lab_record|
        Rails.logger.info "Lab record #{lab_record.id} #{lab_record.row}"

        update_cell(
          mapped_row_number(lab_record),
          context.lab_record.patient_id_index,
          lab_record.patient_id
        )
      end
    end

    private

    def mapped_row_number(lab_record)
      lab_record.row + context.lab_record.data_rows_from - 1
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

    def first_row
      @first_row ||= context.lab_record.data_rows_from
    end

    def last_row
      @last_row ||= context.lab_record.data_rows_to
    end
  end
end
