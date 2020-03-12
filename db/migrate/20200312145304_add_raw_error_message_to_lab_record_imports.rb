class AddRawErrorMessageToLabRecordImports < ActiveRecord::Migration[5.2]
  def change
    add_column :lab_record_imports, :raw_error_message, :string
  end
end
