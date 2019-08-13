class CreateLabRecordRows < ActiveRecord::Migration[5.2]
  def change
    create_table :lab_records do |t|
      t.jsonb :content
      t.references :lab_record_import, foreign_key: true
      t.references :site, foreign_key: true
      t.integer :patient_id_state, default: 0
      t.integer :row

      t.timestamps
    end
  end
end
