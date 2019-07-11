module Api
  module V1
    class AntibioticConsumptionStatsController < ApiController
      def index
        render_paginated AntibioticConsumptionStat.all
      end
    end
  end
end
