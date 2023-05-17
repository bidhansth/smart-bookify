class ClientdashboardsController < ApplicationController
    before_action :check_admin, only: [:index]
    
    def index
      @bookings = Booking.where(is_accepted: false).where(:timeslots => {:client_id => current_client.id}).joins(:timeslot)
      @accepted_bookings = Booking.where(is_accepted: true).where(:timeslots => {:client_id => current_client.id}).joins(:timeslot)
      @today_bookings = @accepted_bookings.where(:timeslots => {:date => Date.today})
      @url = request.base_url + book_client_path(clientid: current_client.id.to_s)
    end

    def tomorrow_bookings
      @accepted_bookings = Booking.where(is_accepted: true).where(:timeslots => {:client_id => current_client.id}).joins(:timeslot)
      @tomorrow_bookings = @accepted_bookings.where(:timeslots => {:date => Date.tomorrow})
    end

    def upcoming_bookings
      @accepted_bookings = Booking.where(is_accepted: true).where(:timeslots => {:client_id => current_client.id}).joins(:timeslot)
      @upcoming_bookings = @accepted_bookings.where(:timeslots => {:date => 2.days.from_now..})
    end

    def accept_booking
      @booking = Booking.find(params[:id])
      @booking.is_accepted = true
      @booking.save
      @timeslot = Timeslot.find(@booking.timeslot_id)
      @timeslot.is_confirm = true
      @timeslot.booking_id = @booking.id
      @timeslot.save
      BookingMailer.booking_accept(@booking).deliver_later
      redirect_to clientdashboard_path, notice: "Booking accepted."
    end

    def decline_booking
      @booking = Booking.find(params[:id])
      BookingMailer.booking_decline(@booking).deliver_now
      @booking.destroy
      redirect_to clientdashboard_path, notice: "Booking declined."
    end

    def time_slots
    end

    def check_admin
      redirect_to admin_path if current_client.present? && current_client.is_admin
    end
end