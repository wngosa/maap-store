class CreateAntibiotics < ActiveRecord::Migration[5.1]
  def change
    create_table :antibiotics do |t|
      t.string :name
      t.string :strength_value
      t.string :strength_unit
      t.string :form
      t.string :pack_size
      t.string :brand

      t.timestamps
    end
  end
end
