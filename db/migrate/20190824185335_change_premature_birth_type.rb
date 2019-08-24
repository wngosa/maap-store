class ChangePrematureBirthType < ActiveRecord::Migration[5.2]
  def change
    remove_column :patient_entries, :premature_birth
    add_column :patient_entries, :premature_birth, :string
  end
end
