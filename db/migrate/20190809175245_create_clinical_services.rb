class CreateClinicalServices < ActiveRecord::Migration[5.2]
  def change
    create_table :clinical_services do |t|
      t.string :name
      t.timestamps
    end
  end
end
