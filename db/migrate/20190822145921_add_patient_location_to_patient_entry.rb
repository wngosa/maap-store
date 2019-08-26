class AddPatientLocationToPatientEntry < ActiveRecord::Migration[5.2]
  def change
    add_reference :patient_entries, :patient_location, foreign_key: true
  end
end
