module InteractorsLRI
  class InsertLabRecords
    include Interactor
    include ApplicationHelper

    def call # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      Rails.logger.info 'Insert Lab Records started'

      lab_record_import = context.record
      return if lab_record_import.skip_obfuscation? || !lab_record_import.rows_file.attached?

      blob_key = lab_record_import.rows_file.blob.key
      rows = json_from_active_storage_attachment(blob_key)

      # Don't process again if this step was already completed succesfully
      return if rows.length == lab_record_import.lab_records.count

      ActiveRecord::Base.transaction do
        rows.each do |attributes|
          lab_record = LabRecord.new(attributes)
          lab_record.site = lab_record_import.site
          lab_record.lab_record_import = lab_record_import
          next lab_record unless lab_record_import.patient_id_index

          lab_record.patient_id = lab_record.content[lab_record_import.patient_id_index]['w']
          lab_record.save
        end
      end

      Rails.logger.info 'Insert Lab Records finished'
    end
  end
end
