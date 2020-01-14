class AddDeletedAtToAntibioticConsumptionStats < ActiveRecord::Migration[5.2]
  def change
    add_column :antibiotic_consumption_stats, :deleted_at, :datetime
    add_index :antibiotic_consumption_stats, :deleted_at
  end
end
