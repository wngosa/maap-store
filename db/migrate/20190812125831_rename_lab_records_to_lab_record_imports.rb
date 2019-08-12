class RenameLabRecordsToLabRecordImports < ActiveRecord::Migration[5.2]
  def change
    rename_table :lab_records, :lab_record_imports
  end
end
