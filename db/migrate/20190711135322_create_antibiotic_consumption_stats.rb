class CreateAntibioticConsumptionStats < ActiveRecord::Migration[5.1]
  def change
    create_table :antibiotic_consumption_stats do |t|
      t.datetime :date

      t.timestamps
    end
  end
end
