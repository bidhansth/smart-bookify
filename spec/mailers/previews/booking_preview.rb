# Preview all emails at http://localhost:3000/rails/mailers/booking
class BookingPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/booking/booking_confirm
  def booking_confirm
    BookingMailer.booking_confirm
  end

end
