class AddS3FilePathToLabRecordImports < ActiveRecord::Migration[5.2]
  def change
    add_column :lab_record_imports, :s3_file_path, :string
  end
end
