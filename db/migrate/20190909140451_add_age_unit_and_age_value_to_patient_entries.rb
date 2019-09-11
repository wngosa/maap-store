class AddAgeUnitAndAgeValueToPatientEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :patient_entries, :age_value, :integer
    add_column :patient_entries, :age_unit, :string
  end
end
