class ElectronicPharmacyStockRecord < ApplicationRecord
  belongs_to :site
  has_one_attached :sheet_file

  enum obfuscation_state: {
    pending: 0,
    obfuscated: 1
  }

  def name
    id
  end

  def obfuscated?
    obfuscation_state == 'obfuscated'
  end

  def rows
    JSON[self[:rows]]
  end

  def columns
    JSON[self[:columns]]
  end

  def phi
    JSON[self[:phi]]
  end

  def date
    JSON[self[:date]]
  end
end
