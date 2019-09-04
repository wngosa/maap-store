module AnonymizeLabRecordImport
  class SaveSheet
    include Interactor

    def call # rubocop:disable Metrics/AbcSize
      context.sheet_file.write("#{context.sheet_path}.xlsx")
      context.lab_record_import.sheet_file.attach(
        io: File.open("#{context.sheet_path}.xlsx"),
        filename: "#{context.lab_record_import.site_id || "unknown-site"}-#{context.lab_record_import.id}.#{file_extension}"
      )
      context.lab_record_import.save!
    end

    private

    def file_extension
      context.sheet_type == :xlsx ? 'xlsx' : 'xls'
    end
  end
end
