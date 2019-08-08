class AddWhoAtcIndexToAntibiotics < ActiveRecord::Migration[5.1]
  def change
    add_column :antibiotics, :who_atc_index, :string
  end
end
