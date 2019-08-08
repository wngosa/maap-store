class RenameLabsToSites < ActiveRecord::Migration[5.1]
  def change
    rename_table :labs, :sites
  end
end
