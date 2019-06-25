module Api
  module V1
    class ApiController < ::ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken
      include Pagination

      before_action :authenticate_user!
    end
  end
end
