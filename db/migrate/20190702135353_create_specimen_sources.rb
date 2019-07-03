class CreateSpecimenSources < ActiveRecord::Migration[5.1]
  def change
    create_table :specimen_sources do |t|
      t.string :name

      t.timestamps
    end
  end
end
