class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name username])

    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name username])
  end
end
