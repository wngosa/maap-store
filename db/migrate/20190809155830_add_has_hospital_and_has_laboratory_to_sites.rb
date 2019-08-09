class AddHasHospitalAndHasLaboratoryToSites < ActiveRecord::Migration[5.2]
  def change
    add_column :sites, :has_hospital, :boolean
    add_column :sites, :has_laboratory, :boolean
  end
end
