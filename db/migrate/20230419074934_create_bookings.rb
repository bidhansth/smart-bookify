class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.text :user_name, null: false
      t.text :user_email, null: false
      t.integer :user_contact, null: false
      t.text :description, null: false
      t.integer :timeslot_id, null: false
      t.boolean :is_accepted, default: false

      t.timestamps
    end
  end
end
