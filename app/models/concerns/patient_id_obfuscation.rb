module PatientIdObfuscation
  extend ActiveSupport::Concern

  included do
    # TODO: migrate db for enum
    # enum patient_id_state: ['pending', 'obfuscated']

    scope :obfuscation_pending, -> { where(patient_id_state: ['pending', nil]) }
  end
end