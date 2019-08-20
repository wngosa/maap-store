class LabRecordImport < ApplicationRecord
  belongs_to :site
  has_one_attached :sheet_file
  has_many :lab_records, dependent: :destroy

  accepts_nested_attributes_for :lab_records

  def name
    id
  end

  def rows
    JSON[self[:rows]]
  end

  def columns
    JSON[self[:columns]]
  end

  def patient_or_lab_record_id
    JSON[self[:patient_or_lab_record_id]]
  end

  def phi
    JSON[self[:phi]]
  end

  def date
    JSON[self[:date]]
  end

  def patient_id_index
    patient_or_lab_record_id.key('patientId').to_i
  end
end
