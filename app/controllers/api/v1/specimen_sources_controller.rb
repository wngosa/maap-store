module Api
  module V1
    class SpecimenSourcesController < ApiController
      def index
        render_paginated filter(SpecimenSource.all)
      end
    end
  end
end
