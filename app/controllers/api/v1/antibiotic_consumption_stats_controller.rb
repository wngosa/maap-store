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

      private

      def permitted_params
        params.require(:antibiotic_consumption_stat).permit(
          :antibiotic_id, :recipient_facility, :issued, :quantity, :balance,
          :recipient_unit, :date
        )
      end
    end
  end
end
