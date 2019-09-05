module AnonymizeLabRecordImport
  class SaveSheet
    include Interactor

    def call # rubocop:disable Metrics/AbcSize
      file_id = (context.lab_record_import.site_id || 'unknown-site').to_s
      filename = "#{file_id}-#{context.lab_record_import.id}"

      save_file!
      context.lab_record_import.sheet_file.attach(
        io: File.open(context.sheet_path),
        filename: "#{filename}.#{file_extension}"
      )
      context.lab_record_import.save!
    end

    private

    def save_file!
      if context.sheet_type == :csv
        CSV.open(context.sheet_path, 'wb') { |csv| context.sheet_file.each { |row| csv << row } }
      else
        context.sheet_path = "#{context.sheet_path}.xlsx"
        context.sheet_file.write(context.sheet_path)
      end
    end

    def file_extension
      context.sheet_type.to_s
    end
  end
end
