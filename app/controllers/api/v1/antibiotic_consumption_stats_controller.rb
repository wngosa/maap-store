module Api
  module V1
    class AntibioticConsumptionStatsController < ApiController
      def index
        render_paginated filter(AntibioticConsumptionStat.all)
      end
    end
  end
end
