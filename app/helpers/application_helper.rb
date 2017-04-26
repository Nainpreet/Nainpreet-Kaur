#
module ApplicationHelper

  # def name
  #    Doctor.all.each do |doc|
  #      name = doc.user.name
  #    end
  # end

  # def doctors
  #   doctors = User.where(role: 'Doctor')
  # end
  #
  # def timeslots
  #   timeslots = ['8AM-10Am', '11PM-1PM', '2PM-4PM', '5PM-7PM', 'Not Available']
  # end
  #
  # def days
  #   days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Not Available']
  # end
  #
  # def time_slots_dropdown
  #   time_slots_dropdown = Doctor.find(@doctors.id).time_slots.split(',')
  # end
  #
  #

  def days_dropdown2
    if current_user.role == 'Doctor'
      days = Doctor.find_by_user_id(current_user.id).days.split(',')
    else
      days = Doctor.find(@doctors.id).days.split(',')
    end
    intial_date = Time.now
    final_Date = intial_date + 1.week
    days_dropdown = []
    begin
      days.each do |d|
        if intial_date.strftime('%A').capitalize == d
          days_dropdown << intial_date.strftime('%b %d %Y %A')
        end
      end
      intial_date += 1.day
    end while intial_date < final_Date
    days_dropdown2 = days_dropdown
  end

  def doctor_alloted?
    !Doctor.find_by(user_id: current_user.id).nil?
  end

  def mobile_verification_button
    return '' unless current_user.needs_mobile_number_verifying?
    html = <<-HTML
      <h3>Verify Mobile Number</h3>
      #{form_tag(verifications_path, method: 'post')}
      #{button_tag('Send verification code', type: 'submit')}
      </form>
    HTML
    html.html_safe
  end

  def verify_mobile_number_form
    # return '' if current_user.verification_code.empty?
    # p current_user.verification_code.empty?
    html = <<-HTML
      <h3>Enter Verification Code</h3>
      #{form_tag(verifications_path, method: 'put')}
      #{text_field_tag('verification_code')}
      #{button_tag('Submit', type: 'submit')}
      </form>
    HTML
    html.html_safe
  end
end
