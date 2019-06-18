module Response
  module JSONParser
    def response_body
      ActiveSupport::JSON.decode(response.body).symbolize_keys if response.present? && response.body.present?
    end
  end
end

RSpec.configure do |config|
  config.include Response::JSONParser, type: :controller
end
