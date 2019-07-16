module Api
  module V1
    class CultureTypesController < ApiController
      def index
        render_paginated filter(CultureType.all)
      end
    end
  end
end
