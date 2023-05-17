class CreateTimeslots < ActiveRecord::Migration[7.0]
  def change
    create_table :timeslots do |t|
      t.date :date
      t.time :start_time
      t.time :end_time
      t.references :client, foreign_key: true
      t.integer :booking_id
      t.boolean :is_confirm, default: false
      t.boolean :is_custom, default: false

      t.timestamps
    end
  end
end
