namespace :clean do
  desc "Sends notifications to patients regarding appointments"
  task :send => :environment do
    Rails.logger.debug 'Debug: Notifications running'
    Rails.logger.info 'Info: Notifications running'
       # This is where to decide whether to send to any given individual user
    Appointment.all.each do |app|
     if app.app_date < Date.today && app.status == 'Pending'
        app.delete
        UserMailer.appointment_notification(app.user, app.doctor.user.name).deliver
     end
   end
  end
end
