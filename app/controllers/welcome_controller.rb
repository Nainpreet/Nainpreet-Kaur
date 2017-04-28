#
class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      if current_user.role == 'admin'
        redirect_to rails_admin_path
      elsif  current_user.role == 'Doctor'
        @records = Appointment.where(status: ['Pending'])
        @appointments = @records.where(doctor_id: Doctor.find_by(user_id: current_user.id).id)
        unless @appointments.empty?
          flash[:notice] = "You have some new appointments"
        end
         render 'verifications/new'
      elsif current_user.role == 'Patient'
        render 'verifications/new'
      end
    end
  end

  def contact
  end
end
