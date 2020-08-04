require 'rubyXL/convenience_methods/cell'

module InteractorsLRI
  class HashPatientsInFile
    include Interactor

    def call # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      return if context.record.skip_obfuscation?

      sheet_file = nil
      if context.sheet_type == :csv 
        sheet_file = SheetHelper::CSV.new(context.sheet_file)
      elsif context.sheet_type == :xls
        sheet_file = SheetHelper::XLS.new(context.sheet_file)
      else
        raise StandardError.new "Only XLS and CSV format supported"
      end

      Rails.logger.info "Patients hashing in file '#{context.record.file_name}' started"

      header_cell = sheet_file.read(
        context.record.header_row - 1, 
        context.record.patient_id_index
      ).to_s

      if header_cell.empty?
        sheet_file.update_cell(
          context.record.header_row - 1,
          context.record.patient_id_index,
          'Patient Id'
        )
      end
      context.record.lab_records.obfuscated.order(row: :asc).find_each do |lab_record|
        sheet_file.update_cell(
          mapped_row_number(lab_record),
          context.record.patient_id_index,
          lab_record.patient_id
        )
      end

      Rails.logger.info "Patients hashing in file '#{context.record.file_name}'' finished"
    end

    private

    def mapped_row_number(lab_record)
      lab_record.row + context.record.data_rows_from - 1
    end
  end
end
