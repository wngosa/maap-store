ActiveAdmin.register AntibioticConsumptionStat do
  actions :edit, :update, :show, :index

  permit_params :date, :antibiotic_id, :issued, :quantity, :balance,
                :recipient_facility, :recipient_unit, :site_id
end
