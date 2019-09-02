ActiveAdmin.register Antibiotic do
  preserve_default_filters!
  remove_filter :antibiotic_consumption_stats

  actions :index, :show, :new, :create, :edit, :update
  permit_params :name, :strength_value, :strength_unit, :form, :pack_size, 
                :brand

  form do |f|
    inputs 'Details' do
      input :name
      input :strength_value
      input :strength_unit
      input :form
      input :pack_size
      input :brand
    end
    actions
  end
end
