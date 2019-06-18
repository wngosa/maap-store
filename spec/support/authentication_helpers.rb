module AuthenticationHelpers
  def authenticate(user)
    request.headers.merge!(user.create_new_auth_token)
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelpers, type: :controller
end
