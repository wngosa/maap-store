module Api
  module V1
    class LabsController < ApiController
      def index
        render_paginated Lab.all
      end

      def create
        lab = Lab.new(permitted_params)
        if lab.save
          render json: lab, status: :created
        else
          render json: { errors: lab.errors }, status: :unprocessable_entity
        end
      end

      private

      def permitted_params
        params.require(:lab).permit(
          :name, :address, :location, :ownership, :has_farmacy,
          :identified_patients, :permanently_identified_patients
        )
      end
    end
  end
end
