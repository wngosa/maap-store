class AddSiteToLabRecordImport < ActiveRecord::Migration[5.2]
  def change
    add_reference :lab_record_imports, :site, foreign_key: true
  end
end
