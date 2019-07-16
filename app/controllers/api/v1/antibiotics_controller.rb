module Api
  module V1
    class AntibioticsController < ApiController
      def index
        render_paginated filter(Antibiotic.all)
      end

      def create
        antibiotic = Antibiotic.new(permitted_params)
        if antibiotic.save
          render json: antibiotic, status: :created
        else
          render json: { errors: antibiotic.errors }, status: :unprocessable_entity
        end
      end

      private

      def permitted_params
        params.require(:antibiotic).permit(
          :name, :strength_value, :strength_unit, :form, :pack_size, :brand
        )
      end
    end
  end
end
