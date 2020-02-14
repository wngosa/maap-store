ActiveAdmin.register AntibioticConsumptionStat do
  preserve_default_filters!

  actions :edit, :update, :show, :index, :destroy

  permit_params :date, :antibiotic_id, :issued, :quantity, :balance,
                :recipient_facility, :recipient_unit, :site_id

  filter :antibiotic, collection: -> {
    Antibiotic.all.map do |antibiotic|
      [
        "#{antibiotic.name} #{antibiotic.form} #{antibiotic.strength_value}#{antibiotic.strength_unit} (#{antibiotic.brand})",
        antibiotic.id
      ]
    end
  }

  csv do
    column :id
    column :antibiotic_id
    column :issued do |antibiotic_consumption_stat|
      antibiotic_consumption_stat.issued ? 'In' : 'Out'
    end
    column :quantity
    column :balance
    column :recipient_facility
    column :recipient_unit
    column :date
    column :site_id
    column :created_at
    column :updated_at
  end

  index do
    column :id
    column :date
    column :created_at
    column :updated_at
    column :antibiotic
    column :issued do |antibiotic_consumption_stat|
      antibiotic_consumption_stat.issued ? 'In' : 'Out'
    end
    column :quantity
    column :balance
    column :recipient_facility
    column :recipient_unit
    column :site

    actions
  end
end
