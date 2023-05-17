json.extract! booking, :id, :user_name, :user_email, :user_contact, :description, :timeslot_id, :created_at, :updated_at
json.url booking_url(booking, format: :json)
