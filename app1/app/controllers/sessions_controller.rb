class SessionsController < ApplicationController

  # google ouath
  
  def googleAuth
    access_token = request.env["omniauth.auth"]
    render json: access_token
  end
end