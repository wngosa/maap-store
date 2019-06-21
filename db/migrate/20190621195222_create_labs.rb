class CreateLabs < ActiveRecord::Migration[5.1]
  def change
    create_table :labs do |t|
      t.string :name
      t.string :address
      t.string :location
      t.string :ownership
      t.boolean :has_farmacy
      t.boolean :identified_patients
      t.boolean :permanently_identified_patients

      t.timestamps
    end
  end
end
