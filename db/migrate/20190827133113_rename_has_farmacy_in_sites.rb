class RenameHasFarmacyInSites < ActiveRecord::Migration[5.2]
  def change
    rename_column :sites, :has_farmacy, :has_pharmacy
  end
end
