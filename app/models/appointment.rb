class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :doctor
  validates :time_slots, presence: true
  validates :app_date, presence: true
end
