class Patient < ApplicationRecord
  validates :patient_id, presence: true, uniqueness: :lab_id
end
