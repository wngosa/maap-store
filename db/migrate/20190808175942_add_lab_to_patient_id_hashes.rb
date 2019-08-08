class AddLabToPatientIdHashes < ActiveRecord::Migration[5.2]
  def change
    add_reference :patient_id_hashes, :site, foreign_key: true
  end
end
