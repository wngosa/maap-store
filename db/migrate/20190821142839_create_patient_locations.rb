class CreatePatientLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :patient_locations do |t|
      t.string :name
      t.timestamps
    end
  end
end
