module Api
  module V1
    class ClinicalServicesController < ApiController
      def index
        render_paginated filter(ClinicalService.all)
      end
    end
  end
end
