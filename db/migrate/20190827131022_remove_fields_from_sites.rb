class RemoveFieldsFromSites < ActiveRecord::Migration[5.2]
  def change
    remove_column :sites, :level
    remove_column :sites, :permanently_identified_patients
    remove_column :sites, :teaching
    remove_column :sites, :identified_patients
  end
end
