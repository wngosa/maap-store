module Api
  module V1
    class PatientsController < ApiController
      def index
        render_paginated filter(Patient.all)
      end

      def create
        result = Patients::Create.call(patient_params: create_permitted_params)

        if result.success?
          render json: result.patient, status: :created
        else
          render json: result.errors, status: :unprocessable_entity
        end
      end

      def update
        patient = Patient.find(params[:id])

        if patient.update(update_permitted_params)
          render json: patient, status: :accepted
        else
          render json: patient.errors, status: :unprocessable_entity
        end
      end

      private

      def update_permitted_params
        params.require(:patient).permit(:gender, :year_of_birth, :level_of_education)
      end

      def create_permitted_params
        params.require(:patient).permit(:patient_id, :gender, :year_of_birth, :level_of_education,
                                        :site_id)
      end
    end
  end
end
