module Sheets
  class PruneTableFields
    include Interactor

    def call
      Rails.logger.info "Pruning raw rows for record #{context.record.class} #{context.record.id}"
      context.record.rows = {}
      context.record[context.state_attribute] = :obfuscated
      context.record.save!
    end
  end
end
