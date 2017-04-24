#
class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      if current_user.role == 'admin'
        redirect_to rails_admin_path
      else current_user.role == 'Doctor' || current_user.role == 'Patient'
        render 'verifications/new'
      end
    end
  end

  def contact
  end
end
