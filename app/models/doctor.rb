#
class Doctor < ApplicationRecord
  belongs_to :department
  belongs_to :user
  # validates :users_id, presence: true
  # validates :users_id, presence: true
end
