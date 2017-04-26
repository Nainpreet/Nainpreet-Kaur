class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  geocoded_by :address
  after_validation :geocode
  has_many :doctors
  has_many :appointments
  devise :database_authenticatable, :registerable,
     :recoverable, :rememberable, :trackable, :validatable,:confirmable, :lockable, :omniauthable
  # validates_uniqueness_of :phone
  # validates :phone, phone: { possible: false, allow_blank: true, types: [:mobile] }
  validates :name, presence: true
  validates :dob, presence: true
  validates :address, presence: true
  validates :phone, presence: true
  validates :role, presence: true
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def needs_mobile_number_verifying?
    if is_verified
      return false
    end
    if phone.empty?
      return false
    end
    return true
  end

end
