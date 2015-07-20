class TracksController < ApplicationController
  before_action :set_playlist 
  require 'rspotify'

  
  def search
    @query = params[:q]

    unless @query.blank?
      RSpotify::authenticate(ENV["client_id"], ENV["client_secret"])
      @tracks = RSpotify::Track.search(@query)  
    end
    render layout: false
  end

  def create
    @playlist.tracks.create(track_params)
    redirect_to playlist_path(@playlist) 
  end

  def delete
    @playlist.track.destroy
    redirect_to playlist_path(@playlist)
  end

  private

  def set_playlist
    @playlist = Playlist.find(params[:playlist_id])
  end

  def track_params
    params.require(:track).permit(:name, :album, :artists, :uri, :contributer)
  end
end