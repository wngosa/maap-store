ActiveAdmin.register Site do
  permit_params :name, :address, :ownership, :has_farmacy,
                :identified_patients, :permanently_identified_patients
end
