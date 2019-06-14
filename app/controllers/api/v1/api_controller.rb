module Api
  module V1
    class ApiController < ActionController::Base
      include DeviseTokenAuth::Concerns::SetUserByToken
    end
  end
end
