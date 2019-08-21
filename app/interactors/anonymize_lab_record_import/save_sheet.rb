module AnonymizeLabRecordImport
  class SaveSheet
    include Interactor

    def call
      context.sheet_file.write("#{context.sheet_path}.xlsx")
      context.lab_record.sheet_file.attach(
        io: File.open("#{context.sheet_path}.xlsx"),
        filename: "Download.#{file_extension}"
      )
      context.lab_record.save!
    end

    private

    def file_extension
      context.sheet_type == :xlsx ? 'xlsx' : 'xls'
    end
  end
end
