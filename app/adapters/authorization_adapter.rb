class AuthorizationAdapter < ActiveAdmin::AuthorizationAdapter
  def authorized?(action, subject = nil)
    case subject
    when normalized(PatientIdHash)
      user.admin?
    else
      return action == :read if user.viewer?

      true
    end
  end
end
