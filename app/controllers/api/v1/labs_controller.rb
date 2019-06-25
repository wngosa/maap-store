module Api
  module V1
    class LabsController < ApiController
      def index
        render_paginated Lab.all
      end
    end
  end
end
