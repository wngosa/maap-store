module Sheets
  class PurgeRowsFile
    include Interactor

    def call # rubocop:disable Metrics/AbcSize
      Rails.logger.info "Purging rows_file for record #{context.record.class} #{context.record.id} started"

      context.record.rows_file.purge_later if context.record.rows_file.attached?
      send_to_obfuscated_state!
      context.record.save!

      Rails.logger.info "Purging rows_file for record #{context.record.class} #{context.record.id} finished"
    end

    private

    def send_to_obfuscated_state!
      context.record[context.state_attribute] = :obfuscated
    end
  end
end
