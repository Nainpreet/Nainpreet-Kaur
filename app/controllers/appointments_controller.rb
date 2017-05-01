#
class AppointmentsController < ApplicationController
  def index
    flash[:notice] = nil
    authorize! :index, :appointment
    @records = Appointment.where.not(status: ['Completed', 'Cancel', 'Reject'])
    if current_user.role == 'Patient'
      @appointments = @records.where('user_id = ? ', current_user.id).page params[:page]
    else
      if current_user.doctors.empty?
        flash[:notice] = "You have no appointments yet"
        redirect_to doctor_path(current_user.id)
      else
        @appointments = @records.where(doctor_id: Doctor.find_by(user_id: current_user.id).id).page params[:page]
      end
    end
  end

  def appointment_history
    flash[:notice] = nil
    authorize! :appointment_history, :appointment
    @records = Appointment.where(status: ['Completed', 'Cancel', 'Reject'])
    if current_user.role == 'Patient'
      @history = @records.where('user_id = ? ', current_user.id).page params[:page]
    else
      if current_user.doctors.empty?
        flash[:notice] = "You have no appointments history yet"
        redirect_to doctor_path(current_user.id)
      else
        @history = @records.where(doctor_id: Doctor.find_by(user_id: current_user.id).id).page params[:page]
      end
    end
  end

  def appointment_status
    @id = Appointment.find(params[:id])
    @status = @id.update_attributes(status: params[:status])
    if params[:status] == 'Completed'
      UserMailer.appointment_completed(@id.user, @id.doctor.user.name, @id.app_date).deliver
      redirect_to appointment_history_path
    elsif params[:status] == 'Reject'
      redirect_to appointment_history_path
      UserMailer.appointment_reject(@id.user, @id.doctor.user.name).deliver
    elsif params[:status] == 'Follow Up'
      redirect_to edit_appointment_path(params[:id])
    elsif params[:status] == 'Accept'
      UserMailer.appointment_confirmation(@id.user, @id.doctor.user.name).deliver
      redirect_to appointments_path
    end
  end

  def appointment_cancel
    @id = Appointment.find(params[:id])
    if @id.status == 'Pending'
      if Date.today + 1.day < @id.app_date
        flash[:success] = 'Your appointment has been cancel.'
        @id.update_attributes(status: 'Cancel')
        UserMailer.appointment_cancel(@id.user, @id.doctor.user.name).deliver
        redirect_to appointments_path
      else
        flash[:success] = 'You can cancel appointment before 24 hours.'
        redirect_to appointments_path
      end
    else
        flash[:success] = "You are not authorized to cancel this appointment"
          redirect_to appointments_path
    end
  end

  def new
    authorize! :new, :appointment
    @appointment = Appointment.new
  end

  def create
    @time = params[:appointment][:time_slots]
    @date = params[:appointment][:app_date]
    @time = DateTime.parse(@time).strftime("%H:%M")

    if  DateTime.now.strftime('%b %d %Y %A') == @date && (@time.to_i <= Time.zone.now.hour+3)
      @appointment = Appointment.new
      flash[:notice] = "You can take appointment minimum 3 hours before"
      redirect_to new_appointment_path
    else
      @appointment = Appointment.create(user_id: current_user.id, doctor_id: params[:appointment][:doctor_id], app_date: params[:appointment][:app_date], date: Date.today, time_slots: params[:appointment][:time_slots], symptoms: params[:appointment][:symptoms])
      if @appointment.save
        flash[:notice] = "Your appointment has been successfully sent to doctor"
        redirect_to appointment_path(@appointment)
      else
        redirect_to new_appointment_path
      end
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
    authorize! :show, @appointment
  end

  def edit
    @appointment = Appointment.find(params[:id])
    authorize! :edit, @appointment
  end

  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.update_attributes(symptoms: params[:appointment][:symptoms], medications: params[:appointment][:medications], app_date: params[:days])
      redirect_to appointments_path
      UserMailer.appointment_follow(@appointment.user, @appointment.doctor.user.name, @appointment.app_date).deliver
    else
      render 'edit'
    end
  end

  def updatedoctors
    @doctors = Department.find(params[:id]).doctors
  end

  def updatetime
    @time_slots = Doctor.find(params[:id]).time_slots
  end

  def updatedate
    @doctors = Doctor.find(params[:id])
  end
end
