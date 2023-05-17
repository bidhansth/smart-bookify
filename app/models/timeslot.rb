class Timeslot < ApplicationRecord
  belongs_to :client
  has_many :bookings

end
