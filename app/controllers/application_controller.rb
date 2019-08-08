class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  # skip_before_action :valid_request_origin?

  # see https://github.com/rails/rails/issues/30658
  def valid_request_origin?
    true
  end
end
