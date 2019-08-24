class RemovePlainLocationColumnFromPatientEntry < ActiveRecord::Migration[5.2]
  def change
    remove_column :patient_entries, :location
  end
end
