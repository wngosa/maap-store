ActiveAdmin.register PatientIdHash do
  actions  :index, :destroy

  index :download_links => false
end
