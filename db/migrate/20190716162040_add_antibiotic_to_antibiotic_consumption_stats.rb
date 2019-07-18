class AddAntibioticToAntibioticConsumptionStats < ActiveRecord::Migration[5.1]
  def change
    add_reference :antibiotic_consumption_stats, :antibiotic, foreign_key: true
  end
end
