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

      def filter(collection)
        original_scope = collection.order(id: :asc)
        s = original_scope.where('date_trunc(\'milliseconds\', updated_at) > ?', params[:updated_at_gth].to_datetime) if params[:updated_at_gth].present? # rubocop:disable Metrics/LineLength
        s = (s || original_scope).or(original_scope.where('id > ?', params[:id_gth])) if params[:id_gth].present? # rubocop:disable Metrics/LineLength
        s || original_scope
      end
    end
  end
end
