#
class PatientsController < ApplicationController

  # def index
  #   @departments = Department.all
  #   @doctors = Doctor.where("department_id = ?", Department.first.id)
  # end
  #
  # def show1
  #   @doctors = Doctor.find_by("id = ?", params[:trip][:doctor_id])
  # end
  #
  # def update_doctors
  #   @doctors = Doctor.where("department_id = ?", params[:department_id])
  #   respond_to do |format|
  #     format.js
  #   end
  # end

  def show
    @patient = User.find(params[:id])
    authorize! :show, @patient
  end

  def map
    @patient = current_user
    authorize! :show, @patient
    @doctors = current_user.appointments.where.not(status: ['Reject', 'Completed', 'Cancel'])
    @hash = Gmaps4rails.build_markers(@patient) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.infowindow user.name
    end
    @hashs = Gmaps4rails.build_markers(@doctors) do |doc, marker|
        marker.lat doc.doctor.user.latitude
        marker.lng doc.doctor.user.longitude
        marker.infowindow doc.doctor.user.name
        marker.picture({
          :url=> "logo.jpg",
          :width  => "30",
          :height => "30"
         })
    end
  end

end
