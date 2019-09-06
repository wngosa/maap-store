class AuthorizationAdapter < ActiveAdmin::AuthorizationAdapter
  def authorized?(action, subject = nil)
    Rails.logger.info action
    Rails.logger.info subject

    case subject
    when normalized(PatientIdHash)
      user.admin?
    else
      return action == :read if user.viewer?

      true
    end
  end
end
