ActiveAdmin.register Site do
  permit_params :name, :address, :location, :site_type, :census, :available_beds,
                :outpatient_by_month, :has_patient_uid, :system_change,
                :ownership, :level,
                :has_infection_disease_department, :infectious_diseases_physicians,
                :infectious_diseases_nurses, :has_amr_comitee, :meet_frequency,
                :has_annual_antibiogram, :stew_team, :has_guideline_antibiotics,
                :has_av_spec_processed, :av_spec_processed, :av_spec_bacterial_grow,
                :has_pharmacy, :has_hospital, :has_laboratory, services_served_by_lab: []

  form do |f|
    ownerships = ['Public', 'Private', 'Mission', 'Military', 'Other']
    inputs 'Details' do
      input :name
      input :address
      input :location
      
      input :level, as: :select, collection: ['Primary', 'Secondary', 'Tertiary']
      input :site_type, as: :select, collection: ['Teaching', 'Non-teaching', 'Unknown'], label: 'Please enter the new site type you want to add'
      input :ownership, as: :select, collection: ['Public', 'Private', 'Mission', 'Military', 'Other'],
                        input_html: { class: 'js-ownership-selector', data: { not: 'Other', action: 'hide', target: '.ownership' } },
                        selected: f.object.ownership.to_s.empty? || ownerships.include?(f.object.ownership) ? f.object.ownership : 'Other'
      input :ownership, wrapper_html: { class: 'ownership' }, input_html: { class: 'js-ownership-other' }

      input :census, label: 'What is the annual patient census at the clinical setting for 2018?'
      input :available_beds, label: 'How many inpatient beds were available at the clinical setting in 2018?'
      input :outpatient_by_month, label: 'What is the average number of outpatients at the clinical setting per month in 2018?'

      input :services_served_by_lab, label: 'What are the clinical services the laboratory serves?',
                                     collection: ['Medical', 'Surgical', 'Pediatric', 'Maternity and Gynacecological', 'Not mentioned', 'Intensive care', 'Emergency', 'Other'],
                                     as: :select,
                                     input_html: { multiple: true }
      input :has_patient_uid, label: 'Does the clinical setting assign unique identifier (identification number) to track patients?/The clinical setting assigns unique identifier (identification number) to track patients?', 
                              input_html: { data: { if: 'not_checked', action: 'hide', target: '.system_change' } }
      input :system_change, label: 'Has there been any change to this system since 2018?', wrapper_html: { class: 'system_change' }

      input :has_infection_disease_department, label: 'Does an infectious disease department exist at the clinical setting?/ The clinical setting has an infectious disease department', 
                                               input_html: { data: { if: 'not_checked', action: 'hide', target: '.has_infection_disease_department' } }
      input :infectious_diseases_physicians, label: 'How many infectious disease (ID) physicians are there in the department', wrapper_html: { class: 'has_infection_disease_department' }
      input :infectious_diseases_nurses, label: 'How many infectious disease (ID) nurses are there in the department', wrapper_html: { class: 'has_infection_disease_department' }

      input :has_amr_comitee, label: 'Does an infectious disease department exist at the clinical setting?/ The clinical setting has an infectious disease department', 
                              input_html: { data: { if: 'not_checked', action: 'hide', target: '.has_amr_comitee' } }
      input :meet_frequency, label: 'What are the frequency of the meetings', wrapper_html: { class: 'has_amr_comitee' }
      input :has_annual_antibiogram, label: 'Is an annual antibiogram generated/Annual antibiogram is generated', 
                                     wrapper_html: { class: 'has_amr_comitee' }
      input :stew_team, label: 'What is the composition of the stewardship team', wrapper_html: { class: 'has_amr_comitee' }
      input :has_guideline_antibiotics, label: 'Are any guidelines referred for antibiotic prescribing/ Has guidelines referred for antibiotic prescribing', wrapper_html: { class: 'has_amr_comitee' }

      input :has_av_spec_processed, label: 'Does the laboratory have information on average number of specimens processed for culture and sensitivity in 2018? / The laboratory has information on average number of specimens processed for culture sensitivity in 2018', input_html: { data: { if: 'not_checked', action: 'hide', target: '.has_av_spec_processed' } }
      input :av_spec_processed, label: 'Average number of specimens processed for bacterial culture in 2018', wrapper_html: { class: 'has_av_spec_processed' }
      input :av_spec_bacterial_grow, label: 'Average number of specimens that yielded bacterial growth and were processed for susceptibility tests, in 2018', wrapper_html: { class: 'has_av_spec_processed' }

      input :has_pharmacy
      input :has_hospital
      input :has_laboratory
    end
    actions
  end
end
