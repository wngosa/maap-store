class AddSiteToAntibioticConsumptionStats < ActiveRecord::Migration[5.2]
  def change
    add_reference :antibiotic_consumption_stats, :site, foreign_key: true
  end
end
