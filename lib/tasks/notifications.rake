namespace :notifications do
  desc "Sends notifications to patients regarding appointments"
  task :send => :environment do
    Rails.logger.debug 'Debug: Notifications running'
    Rails.logger.info 'Info: Notifications running'
       # This is where to decide whether to send to any given individual user
      Appointment.all.each do |app|
       if app.status == 'Accept' || app.status == 'Follow Up'
        if (Date.today + 1.day) == app.app_date
          UserMailer.appointment_remainder(app.user, app.doctor.user.name).deliver
         end
        end
     end
  end
end
