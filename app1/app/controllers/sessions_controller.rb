class SessionsController < ApplicationController

  # google ouath
  
  def googleAuth
    access_token = request.env["omniauth.auth"]
    # render json: access_token
    BunnySender.new.publish(data: access_token.to_json, queue: 'googleOauth')
    # publish user

    #  user = User.from_omniauth(access_token)
    # log_in(user)
    # # Access_token is used to authenticate request made from the rails application to the google server
    # user.google_token = access_token.credentials.token
    # # Refresh_token to request new access_token
    # # Note: Refresh_token is only sent once during the first request
    # refresh_token = access_token.credentials.refresh_token
    # user.google_refresh_token = refresh_token if refresh_token.present?
    # user.save!
    # redirect_to root_path
  end
end