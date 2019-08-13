module Api
  module V1
    class PatientEntriesController < ApiController
      def index
        render_paginated filter(PatientEntry.all)
      end

      def create
        patient_entry = PatientEntry.new(permitted_params)

        if patient_entry.save
          render json: patient_entry, status: :created
        else
          render json: patient_entry.errors, status: :unprocessable_entity
        end
      end

      private

      def permitted_params
        params.require(:patient_entry)
              .permit(:patient_id, :department, :admission_date, :discharge_date,
                      :weight, :height, :pregnancy_status, :premature_birth, :chief_complaint,
                      :patient_transferred, :primary_diagnosis, :primary_diagnosis_icd_code,
                      :acute_myocardial_infarction, :chf, :not_mentioned, :other,
                      :antibiotics_prescribed, :antibiotic, :antibiotic_consumption,
                      :patient_was_on_an_indwelling_medical_device,
                      :medical_device, :infection_acquisition, :discharge_diagnostic,
                      :discharge_diagnostic_icd_code, :patient_outcome_at_discharge)
      end
    end
  end
end
