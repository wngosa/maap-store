module Api
  module V1
    class PatientsController < ApplicationController
      def create
        result = Patients::Create.call(patient_params: permitted_params)

        if result.success?
          render json: result.patient, status: :created
        else
          render json: result.errors, status: :unprocessable_entity
        end
      end

      private

      def permitted_params
        params.require(:patient).permit(:patient_id, :gender, :year_of_birth, :level_of_education, :site_id)
      end
    end
  end
end
