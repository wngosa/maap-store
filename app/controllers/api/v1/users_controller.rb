module Api
  module V1
    class Api::V1::UsersController < Api::V1::ApiController
      def me
        render json: current_user
      end
    end
  end
end
