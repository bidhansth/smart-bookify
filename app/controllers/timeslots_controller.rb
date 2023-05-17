class TimeslotsController < ApplicationController
    def index
      @timeslots = Timeslot.where(
        start_time: Time.now.beginning_of_month.beginning_of_week..Time.now.end_of_month.end_of_week, client_id: current_client.id)
      @current_date = DateTime.now
      if params[:start_date].nil?
        @date = Date.today
      else
        @date = params[:start_date]
      end
    end
   
    def new
      @timeslots = Timeslot.new
    end
  
    def take_date
      @date = params[:start_date]
      redirect_to timeslots_path(start_date: @date)
    end

    def take_time
      @time = params[:start_time]
      @date = params[:date]
      @timeslot = Timeslot.create(date: @date, start_time: @time, client_id: current_client.id)
      redirect_to timeslots_date_path(start_date: @date), notice: "Timeslot created successfully"
    end

    def delete
      @timeslot = Timeslot.find(params[:id])
      @timeslot.destroy
      @date = params[:date]
      redirect_to timeslots_date_path(start_date: @date), notice: "Timeslot deleted successfully"
    end

    private
  
    def timeslots_params
      params.permit(:date, :start_time)
    end
  end
  