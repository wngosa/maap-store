module Api
  module V1
    class SitesController < ApiController
      def index
        render_paginated filter(Site.all)
      end

      def create
        site = Site.new(permitted_params)
        if site.save
          render json: site, status: :created
        else
          render json: { errors: site.errors }, status: :unprocessable_entity
        end
      end

      private

      def permitted_params
        params.require(:site).permit(
          :name, :address, :ownership, :has_pharmacy,
          :identified_patients, :permanently_identified_patients,
          :level, :teaching, :has_hospital, :has_laboratory
        )
      end
    end
  end
end
