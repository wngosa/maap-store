class CreatePatientIdHashes < ActiveRecord::Migration[5.2]
  def change
    create_table :patient_id_hashes do |t|
      t.string :patient_id
      t.string :hashed_value

      t.timestamps
    end
    add_index :patient_id_hashes, :patient_id
  end
end
