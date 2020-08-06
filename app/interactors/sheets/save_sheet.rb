module Sheets
  class SaveSheet
    include Interactor

    def call # rubocop:disable Metrics/AbcSize
      Rails.logger.info "Saving file '#{context.record.file_name}' started"

      site_id = (context.record.site_id || 'unknown-site').to_s
      # TODO. Fix filename. `file_id` actually belogs to previous file id,
      # which is deleted after attaching the new one
      file_id = context.record.sheet_file.id.to_s
      original_filename = context.record.file_name.sub(".#{file_extension}", '')
      filename = "#{file_id}-#{original_filename}-#{site_id}.#{file_extension}"

      save_file!
      context.record.sheet_file.attach(
        io: File.open(context.sheet_path),
        filename: filename
      )
      context.record.save!

      Rails.logger.info "Saving file '#{context.record.file_name}' finished"
    end

    private

    def save_file!
      return save_xls if context.sheet_type == :xls

      save_csv
    end

    def save_csv
      CSV.open(context.sheet_path, 'wb') { |csv| context.sheet_file.each { |row| csv << row } }
    end

    def save_xls
      context.sheet_file.workbook.write(context.sheet_path)
    end

    def file_extension
      context.sheet_type.to_s
    end
  end
end
