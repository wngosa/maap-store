class CreatePatients < ActiveRecord::Migration[5.2]
  def change
    create_table :patients do |t|
      t.string :gender
      t.integer :year_of_birth
      t.string :level_of_education
      t.string :patient_id

      t.timestamps
    end
  end
end
