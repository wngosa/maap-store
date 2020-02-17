class AddUploadedAtToLabRecordImports < ActiveRecord::Migration[5.2]
  def change
    add_column :lab_record_imports, :uploaded_at, :datetime
  end
end
