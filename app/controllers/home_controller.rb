class HomeController < ApplicationController

  def index
    if !current_user
      render layout: false
    else
      redirect_to playlists_path
    end
  end
end