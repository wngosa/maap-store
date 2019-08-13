class AddStayTimespanToPatientEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :patient_entries, :stay_timespan, :bigint
  end
end
