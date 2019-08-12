class AddLevelAndTeachingToSites < ActiveRecord::Migration[5.2]
  def change
    add_column :sites, :level, :string
    add_column :sites, :teaching, :string
  end
end
