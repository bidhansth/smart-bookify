class AddTimeslotToBooking < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :timeslot, null: true, foreign_key: true
  end
end
