module Api
  module V1
    class ApiController < ::ActionController::API
      include DeviseTokenAuth::Concerns::SetUserByToken
      include Pagination

      before_action :authenticate_user!

      rescue_from ActionController::ParameterMissing, with: :parameter_missing

      private

      def parameter_missing(error)
        render json: { error: error }, status: :bad_request
      end
    end
  end
end
