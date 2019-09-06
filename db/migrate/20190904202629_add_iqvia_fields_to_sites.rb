class AddIqviaFieldsToSites < ActiveRecord::Migration[5.2]
  def change
    remove_column :sites, :location, :string
    add_column :sites, :registration_number, :string
    add_column :sites, :registration_body, :string
    add_column :sites, :has_cms, :boolean
    add_column :sites, :location_type, :string
    add_column :sites, :contact_name, :string
    add_column :sites, :contact_designation, :string
    add_column :sites, :contact_email, :string
    add_column :sites, :contact_number, :string
    add_column :sites, :record_keeping_system, :string
    add_column :sites, :other_services, :string
    add_column :sites, :is_specialty_hospital, :boolean
    add_column :sites, :specialties, :string, array: true
    add_column :sites, :other_specialties, :string
    add_column :sites, :served_population_size, :string
    add_column :sites, :average_patients_per_year, :integer
    add_column :sites, :average_icu_length_of_stay, :string
    remove_column :sites, :census, :string
    add_column :sites, :patient_uid_in_lab_records, :boolean
    add_column :sites, :system_change_details, :string
    add_column :sites, :av_spec_fungal_processed, :integer
    add_column :sites, :av_spec_fungal_grow, :integer
    add_column :sites, :frequented_community_pharmacies, :boolean
    add_column :sites, :community_pharmacies_details, :string
    add_column :sites, :pharmacy_contact_name, :string
    add_column :sites, :pharmacy_contact_designation, :string
    add_column :sites, :pharmacy_contact_email, :string
    add_column :sites, :pharmacy_contact_number, :string
    add_column :sites, :pharmacy_records_keeping, :string
    add_column :sites, :pharmacy_data_extraction_records, :string, array: true
    add_column :sites, :cms_dispatch_destinations, :string
    add_column :sites, :cms_dispatch_frequency, :string
    add_column :sites, :cms_collect_stock, :boolean
    add_column :sites, :cms_facility_collector_details, :string
    remove_column :sites, :admitted_by_month, :integer
  end
end
