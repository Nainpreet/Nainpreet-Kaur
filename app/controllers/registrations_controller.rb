#
class RegistrationsController < Devise::RegistrationsController
 before_filter :configure_permitted_parameters, only: [:update,:create]
 def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone, :dob, :role, :address, :gender, :password, :password_confirmation])
   devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone, :dob, :address, :gender, :password, :password_confirmation])
 end

end
