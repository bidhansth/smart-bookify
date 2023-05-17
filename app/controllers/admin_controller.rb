class AdminController < ApplicationController
  include Pagy::Backend
  before_action :require_admin_privilege!, only: [:index]

  def index
    @clients = Client.where("created_at > ?", 3.days.ago).where(is_admin: false).order(created_at: :desc).limit(9)
    @total_clients = Client.where("is_admin==false").count
    @url = request.base_url + book_client_path(clientid: current_client.id.to_s)
    @todays = Timeslot.includes(:bookings, :client).where(date: Date.today).where(bookings: { is_accepted: true})
  end

  def update_theme
    cookies[:theme] = params[:theme]
    redirect_to admin_settings_path
  end

  def profile
    redirect_to clients_edit_path
  end

  def pic
    @client = Client.find(params[:id])
  end

  def clients
    @q = Client.where(is_admin: false).ransack(params[:q])
    @pagy, @client_list = pagy(@q.result(distinct: true), items: 15)
  end

  def delete_client
    @client = Client.find(params[:id])
  
    if @client.destroy
      redirect_to admin_clients_path, notice: "Client deleted."
    else
      redirect_to admin_clients_path, flash: { error: "Client could not be deleted." }
    end
  end

  def require_admin_privilege!
    redirect_to authenticated_root_path, alert: "You are not an admin" unless current_client.present? && current_client.is_admin
  end

  def purge_profile_picture
    current_client.profile_picture.purge
    redirect_to admin_profile_path, notice: "Deleted"
  end
end
