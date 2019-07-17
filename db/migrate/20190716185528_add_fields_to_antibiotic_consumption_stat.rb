class AddFieldsToAntibioticConsumptionStat < ActiveRecord::Migration[5.1]
  def change
    add_column :antibiotic_consumption_stats, :issued, :boolean
    add_column :antibiotic_consumption_stats, :quantity, :integer
    add_column :antibiotic_consumption_stats, :balance, :integer
    add_column :antibiotic_consumption_stats, :recipient_facility, :string
    add_column :antibiotic_consumption_stats, :recipient_unit, :string
  end
end
