class ChangePregnancyStatusType < ActiveRecord::Migration[5.2]
  def change
    remove_column :patient_entries, :pregnancy_status
    add_column :patient_entries, :pregnancy_status, :string
  end
end
