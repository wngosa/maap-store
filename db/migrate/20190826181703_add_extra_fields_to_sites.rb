class AddExtraFieldsToSites < ActiveRecord::Migration[5.2]
  def change
    add_column :sites, :census, :string
    add_column :sites, :site_type, :string
    add_column :sites, :available_beds, :integer
    add_column :sites, :outpatient_by_month, :integer
    add_column :sites, :admitted_by_month, :integer
    add_column :sites, :services_served_by_lab, :string, array: true
    add_column :sites, :has_patient_uid, :boolean
    add_column :sites, :system_change, :string
    add_column :sites, :has_infection_disease_department, :boolean
    add_column :sites, :infectious_diseases_physicians, :integer
    add_column :sites, :infectious_diseases_nurses, :integer
    add_column :sites, :has_amr_comitee, :boolean
    add_column :sites, :meet_frequency, :string
    add_column :sites, :has_annual_antibiogram, :boolean
    add_column :sites, :stew_team, :string
    add_column :sites, :has_guideline_antibiotics, :boolean
    add_column :sites, :has_av_spec_processed, :boolean
    add_column :sites, :av_spec_processed, :integer
    add_column :sites, :av_spec_bacterial_grow, :integer
    add_column :sites, :last_visit, :datetime

  end
end
