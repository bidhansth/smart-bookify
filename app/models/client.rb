class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, with: Devise.email_regexp
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :contact_no, numericality: { only_numeric: true }, length: { is: 10 }
  validate :password_complexity

  has_one_attached :profile_picture
  has_many :timeslots
  has_many :bookings, through: :timeslots
  
  def password_complexity
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{6,70}$/

    errors.add :password, ' must include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
  end

  def self.ransackable_attributes(auth_object = nil)
    ["name", "contact_no", "email"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

end
