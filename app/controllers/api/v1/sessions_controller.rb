module Api
  module V1
    class SessionsController < ::DeviseTokenAuth::SessionsController
      def render_create_success
        # super
        render json: @resource.create_new_auth_token
      end
    end
  end
end
