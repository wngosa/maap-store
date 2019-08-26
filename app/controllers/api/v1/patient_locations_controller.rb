module Api
  module V1
    class PatientLocationsController < ApiController
      def index
        render_paginated filter(PatientLocation.all)
      end
    end
  end
end
