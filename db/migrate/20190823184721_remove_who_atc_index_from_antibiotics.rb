class RemoveWhoAtcIndexFromAntibiotics < ActiveRecord::Migration[5.2]
  def change
    remove_column :antibiotics, :who_atc_index
  end
end
