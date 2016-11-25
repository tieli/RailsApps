class SessionsController < ApplicationController
  def new
    flash.now.alert = warden.message if warden.message.present?
  end

  def create
    warden.authenticate!
    redirect_to root_url, :notice => "Logged In!"
  end

  def destroy
    warden.logout
    redirect_to root_url, :notice => "Logged Out"
  end
end
