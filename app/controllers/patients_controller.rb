#
class PatientsController < ApplicationController
  def show
    @patient = User.find(params[:id])
    authorize! :show, @patient
  end

  def map
    authorize! :map, :patient
    @patient = current_user
    @doctors = current_user.appointments.where.not(status: ['Reject', 'Completed', 'Cancel'])
    @patient_hash = Gmaps4rails.build_markers(@patient) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.infowindow user.name
    end
    @doctor_hashs = Gmaps4rails.build_markers(@doctors) do |doc, marker|
      marker.lat doc.doctor.user.latitude
      marker.lng doc.doctor.user.longitude
      marker.infowindow doc.doctor.user.name
      # marker.picture({
      #   :url=> "logo.jpg",
      #   :width  => "30",
      #   :height => "30"
      #  })
    end
  end
end
