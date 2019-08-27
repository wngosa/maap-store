class AddComorbiditiesToPatientEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :patient_entries, :comorbidities, :string
  end
end
