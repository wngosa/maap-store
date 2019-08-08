class LabRecord < ApplicationRecord
  has_one_attached :sheet_file
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
end
