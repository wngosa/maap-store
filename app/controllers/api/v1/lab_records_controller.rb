module Api
  module V1
    class LabRecordsController < ApplicationController
      def create
        lab_record = LabRecord.new(permitted_params)

        if lab_record.save
          AnonymizeLabRecordFileWorker.perform_async(lab_record.id)
          render json: lab_record, status: :created
        else
          render json: lab_record.errors, status: :unprocessable_entity
        end
      end

      private

      def permitted_params # rubocop:disable Metrics/AbcSize
        params.permit(
          :name, :header_row, :data_rows_from, :data_rows_to, :sheet_file
        ).tap do |whitelisted|
          whitelisted[:rows] = params[:rows] if params[:rows]
          whitelisted[:columns] = params[:columns] if params[:columns]
          whitelisted[:patient_or_lab_record_id] = params[:patient_or_lab_record_id] if params[:patient_or_lab_record_id] # rubocop:disable Metrics/LineLength
          whitelisted[:phi] = params[:phi] if params[:phi]
          whitelisted[:date] = params[:date] if params[:date]
        end
      end
    end
  end
end
