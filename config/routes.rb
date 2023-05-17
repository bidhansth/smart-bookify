Rails.application.routes.draw do
  match '/404', via: :all, to:  'errors#not_found'
  match '/500', via: :all, to: 'errors#internal_server_error'
  resources :bookings
  devise_for :clients
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_scope :client do
    authenticated :client do
      root 'clientdashboards#index', as: :authenticated_root
    end
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
    # for logout
    get '/clients/sign_out', to: 'devise/sessions#destroy'
  end

  get 'clients/edit', to: 'clients#edit'
  
  get 'admin', to: 'admin#index'
  get 'admin/clients', to: 'admin#clients'
  get 'admin/profile', to: 'admin#profile'
  get 'admin/settings', to: 'admin#settings'
  get 'admin/pic', to: 'admin#pic'
  delete "admin/delete_client", to: "admin#delete_client", as: :delete_client
  delete "purge_profile_picture", to: "admin#purge_profile_picture"

  get 'set_theme', to: 'admin#update_theme'

  post 'admin/settings/verifier', to: 'adminpasswords#verifier', as: :verifier_adminpassword
  get 'admin/settings/verify', to: 'adminpasswords#verify', as: :verify_adminpassword
  get "admin/password", to: "adminpasswords#edit", as: :edit_adminpassword
  patch "admin/password", to: "adminpasswords#update"

  get "clientdashboard", to: "clientdashboards#index"
  get "clientdashboard/tomorrow", to: "clientdashboards#tomorrow_bookings"
  get "clientdashboard/upcoming", to: "clientdashboards#upcoming_bookings"
  get "clientdashboard/time_slots", to: "clientdashboards#time_slots"
  get "clientdashboard/accept_booking", to: "clientdashboards#accept_booking", as: :accept_booking
  get "clientdashboard/decline_booking", to: "clientdashboards#decline_booking", as: :decline_booking

  get "timeslots", to: "timeslots#index"
  get "timeslots/delete", to: "timeslots#delete"
  get '/timeslots/date', to: 'timeslots#take_date', as: 'timeslots_date'
  get '/timeslots/time', to: 'timeslots#take_time', as: 'timeslots_time'

  get 'single_day', to: 'bookings#single_day'
  get 'newww_booking', to: 'bookings#new'

  get 'book/:clientid', to: "bookings#index", as: 'book_client'
end
