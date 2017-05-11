#
class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      if current_user.role == 'admin'
        redirect_to rails_admin_path
      elsif current_user.role == 'Patient' || current_user.role == 'Doctor'
        if current_user.is_verified == nil
         render 'verifications/new'
        end
      end
    end
  end

  def contact
  end
end
