class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.appointment_confirmation.subject
  #
  def appointment_confirmation(user,doctor)
    @user = user
    @doctor = doctor
    mail to: user.email, subject: " Appointment Confirmation "
  end

  def appointment_cancel(user,doctor)
    @user = user
    @doctor =doctor
    mail to: user.email, subject: "Appointment Cancellation"
  end

  def appointment_reject(user,doctor)
    @user = user
    @doctor = doctor
    mail to: user.email, subject: "Appointment Rejection"
  end

  def appointment_completed(user,doctor,date)
    @user = user
    @date = date
    @doctor = doctor
    mail to: user.email, subject: "Appointment Completed"
  end

  def appointment_follow(user,doctor,date)
    @user = user
    @doctor = doctor
    @date = date
    mail to: user.email, subject: "Appointment follow up date"
  end

  def appointment_remainder(user, doctor)
    @user = user
    @doctor = doctor
    mail to: user.email, subject: "Appointment Remainder"
  end

  def appointment_notification(user, doctor)
    @user = user
    @doctor = doctor
    mail to: user.email, subject: "Pending appointments"
  end

end
