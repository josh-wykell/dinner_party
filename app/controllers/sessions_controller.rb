class SessionsController < ApplicationController
  
  #  def create
  #   user = RSpotify::User.new(request.env['omniauth.auth'])
  #   if user
  #     session[:user_id] = user.id
  #     redirect_to root_path 
  #   else
  #     redirect_to root_path, :notice => "Fail."
  #   end
  # end

  def create
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    user = User.from_spotify(spotify_user)
    if user
      session[:user_id] = user.id
      redirect_to root_path, :notice => "Authenticated!"
    else
      redirect_to root_path, :notice => "Could not authenticate!"
    end    
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, :notice => "Signed out!"
  end
end