#
class Department < ApplicationRecord
  has_many :doctors
  validates :name, presence: true, format: { with: /\A[a-z A-Z]+\z/,message: "only allows letters" }
end
