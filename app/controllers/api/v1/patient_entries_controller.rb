module Api
  module V1
    class PatientEntriesController < ApiController
      def index
        render_paginated filter(PatientEntry.all)
      end

      def create
        patient_entry = PatientEntry.new(create_permitted_params)

        if patient_entry.save
          render json: patient_entry, status: :created
        else
          render json: patient_entry.errors, status: :unprocessable_entity
        end
      end

      def update
        patient_entry = PatientEntry.find(params[:id])

        if patient_entry.update(update_permitted_params)
          render json: patient_entry, status: :accepted
        else
          render json: patient_entry.errors, status: :unprocessable_entity
        end
      end

      private

      def update_permitted_params
        create_permitted_params
      end

      def create_permitted_params
        params.require(:patient_entry)
              .permit(:patient_id, :department, :stay_timespan, :age_unit, :age_value,
                      :weight, :height, :pregnancy_status, :premature_birth, :chief_complaint,
                      :patient_transferred, :primary_diagnosis, :primary_diagnosis_icd_code,
                      :antibiotics_prescribed, :prescribed_antibiotics_list, :antibiotic_when,
                      :patient_was_on_an_indwelling_medical_device,
                      :medical_device, :infection_acquisition, :discharge_diagnostic,
                      :discharge_diagnostic_icd_code, :patient_outcome_at_discharge,
                      :patient_location_id, :comorbidities)
      end
    end
  end
end
