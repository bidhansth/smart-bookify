class RemoveTimeslotFromBookings < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :timeslot_id, :integer
  end
end
