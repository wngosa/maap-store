class LabRecord < ApplicationRecord
  include PatientIdObfuscation
  # attr_accessor :content

  enum patient_id_state: %w[pending obfuscated]

  belongs_to :lab_record_import
  belongs_to :site
end
