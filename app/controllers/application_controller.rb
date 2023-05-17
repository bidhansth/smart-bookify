class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?


    def after_sign_in_path_for(resource)
      '/clientdashboard' #  URL  to redirect clientdashboard
    end
  
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :email, :password, :password_confirmation, :profession, :contact_no, :location])
      devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :email, :password, :profession, :contact_no, :location, :profile_picture])
    end
  end
  
