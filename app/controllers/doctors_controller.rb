#
class DoctorsController < ApplicationController
  def index
      @doctors = Doctor.all
  end

  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.create(doctor_params)
    if @doctor.save
      flash[:success_doc] = "Successfully Added"
      redirect_to doctors_path
    else
      render 'new'
    end
  end

  def show
    @doctor = User.find(params[:id])
  end

  def edit
    @doctor = Doctor.find(params[:id])
  end

  def update
    @doctor = Doctor.find(params[:id])
    if @doctor.update_attributes(doctor_params)
        redirect_to doctors_path
    else
         render 'edit'
    end
  end

  def destroy
    @doctor = Doctor.find(params[:id])
    if @doctor.destroy
      redirect_to doctors_path
    end
  end

  private

  def doctor_params
    params[:doctor][:days] = params[:doctor][:days].join(',')
    params[:doctor][:time_slots] = params[:doctor][:time_slots].join(',')
    params.require(:doctor).permit(:user_id, :department_id, :days, :time_slots)
  end

end
