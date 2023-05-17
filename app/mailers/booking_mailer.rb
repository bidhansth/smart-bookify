class BookingMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.booking_mailer.booking_confirm.subject
  #
  def booking_confirm(booking, timeslot, client)
    @booking = booking
    @timeslot = timeslot
    @client = client

    mail to: @booking.user_email, subject: "Booking Confirmation"
  end

  def booking_accept(booking)
    @booking = Booking.joins(:timeslot).find(booking.id)
    @client = Client.find(@booking.timeslot.client_id)

    mail to: @booking.user_email, subject: "Booking Accepted"
  end

  def booking_decline(booking)
    @booking = Booking.joins(:timeslot).find(booking.id)
    @client = Client.find(@booking.timeslot.client_id)

    mail to: @booking.user_email, subject: "Booking Declined"
  end
end
