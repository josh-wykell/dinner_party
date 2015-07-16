class HomeController < ApplicationController

  def index
    unless current_user
      render layout: false
    else
      redirect_to playlists_path
    end
  end

  def spotify_search

    @query = params[:q]

    unless @query.blank?
      RSpotify::authenticate(ENV["client_id"], ENV["client_secret"])
      @tracks = RSpotify::Track.search(@query)  
    end
    render layout: false
  end
end