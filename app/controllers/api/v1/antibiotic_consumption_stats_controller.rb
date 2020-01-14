module Api
  module V1
    class AntibioticConsumptionStatsController < ApiController
      def index
        render_paginated filter(AntibioticConsumptionStat.all)
      end

      def create
        antibiotic_consumption_stat =
          AntibioticConsumptionStat.new(permitted_params)
        if antibiotic_consumption_stat.save
          render json: antibiotic_consumption_stat, status: :created
        else
          render json: {
            errors: antibiotic_consumption_stat.errors
          }, status: :unprocessable_entity
        end
      end

      def update
        antibiotic_consumption_stat =
          AntibioticConsumptionStat.find(params[:id])
        if antibiotic_consumption_stat.update(update_permitted_params)
          render json: antibiotic_consumption_stat, status: :accepted
        else
          render json: {
            errors: antibiotic_consumption_stat.errors
          }, status: :unprocessable_entity
        end
      end

      private

      def update_permitted_params
        permitted_params
      end

      def permitted_params
        params.require(:antibiotic_consumption_stat).permit(
          :antibiotic_id, :recipient_facility, :issued, :quantity, :balance,
          :recipient_unit, :date, :site_id
        )
      end
    end
  end
end
