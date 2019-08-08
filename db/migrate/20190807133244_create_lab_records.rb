class CreateLabRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :lab_records do |t|
      t.integer :header_row
      t.integer :data_rows_from
      t.integer :data_rows_to
      t.jsonb :rows
      t.jsonb :columns
      t.jsonb :patient_or_lab_record_id
      t.jsonb :phi
      t.jsonb :date

      t.timestamps
    end
  end
end
