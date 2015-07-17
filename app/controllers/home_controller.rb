class HomeController < ApplicationController

  def index
    unless current_user
      render layout: false
    else
      redirect_to playlists_path
    end
  end
end