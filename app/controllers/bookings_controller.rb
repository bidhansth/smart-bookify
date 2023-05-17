class BookingsController < ApplicationController
  before_action :set_booking, only: %i[ show edit update destroy ]

  # GET /bookings or /bookings.json
  def index
    begin
      @client = Client.find(params[:clientid])
      @timeslots = Timeslot.where(
        start_time: Time.now.beginning_of_month.beginning_of_week..Time.now.end_of_month.end_of_week,
        client_id: @client.id, is_confirm: false)
    rescue
      redirect_to '/404'
    end
  end

  # GET /bookings/1 or /bookings/1.json
  def show
  end

  def single_day
    @date = params[:date]
    @date2 = @date.to_time
    @client_id = params[:client_id]
    @timeslots = Timeslot.where(date: @date, client_id: @client_id, is_confirm: false)
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
    @timeslot = Timeslot.find(params[:id])
    @client = Client.find(params[:client_id])
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings or /bookings.json
  def create
    @booking = Booking.new(booking_params)

    respond_to do |format|
      if @booking.save
        @timeslot = Timeslot.find(@booking.timeslot_id)
        @client = Client.find(@timeslot.client_id)
        BookingMailer.booking_confirm(@booking, @timeslot, @client).deliver_later
        format.html { redirect_to booking_url(@booking) }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1 or /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to booking_url(@booking), notice: "Booking was successfully updated." }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1 or /bookings/1.json
  def destroy
    @booking.destroy

    respond_to do |format|
      format.html { redirect_to bookings_url, notice: "Booking was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def booking_params
      params.require(:booking).permit(:user_name, :user_email, :user_contact, :description, :timeslot_id)
    end
end
