ActiveAdmin.register AntibioticConsumptionStat do
  actions :edit, :update, :show, :index

  permit_params :date, :antibiotic_id, :issued, :quantity, :balance,
                :recipient_facility, :recipient_unit, :site_id

  csv do
    column :id
    column :antibiotic_id
    column :issued
    column :quantity
    column :balance
    column :recipient_facility
    column :recipient_unit
    column :date
    column :site_id
    column :created_at
    column :updated_at
  end
end
