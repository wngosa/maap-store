module Api
  module V1
    class CultureTypesController < ApiController
      def index
        render_paginated CultureType.all
      end
    end
  end
end
