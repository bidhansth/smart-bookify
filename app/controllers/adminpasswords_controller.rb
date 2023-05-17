class AdminpasswordsController < ApplicationController

  def verify
  end

  def verifier
    @check_password = params[:verify_password]
    client = Client.find_for_authentication(:email => current_client.email)
    @verify_answer = client.valid_password?(@check_password)
    if @verify_answer
      render :edit
    else
      redirect_to verify_adminpassword_path, notice: 'Password Incorrect'
    end
  end

  def edit
  end

  def update
    if current_client.update(password_params)
      sign_in(:client, current_client, :bypass => true) #prevents admin from being signed out after password change
      redirect_to authenticated_root_path, notice: "Password Changed"
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:client).permit(:password, :password_confirmation)
  end
end