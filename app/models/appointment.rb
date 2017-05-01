class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :doctor
  validates :time_slots, presence: true
  validates :app_date, presence: true
  validates :symptoms, presence: true
  paginates_per 10
end
