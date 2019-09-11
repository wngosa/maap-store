class CreateElectronicPharmacyStockRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :electronic_pharmacy_stock_records do |t|
      t.integer :header_row
      t.integer :data_rows_from
      t.integer :data_rows_to
      t.jsonb :rows
      t.jsonb :columns
      t.jsonb :phi
      t.jsonb :date
      t.references :site, foreign_key: true
      t.integer :patient_id_state

      t.timestamps
    end
  end
end
