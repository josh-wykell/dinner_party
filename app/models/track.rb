class Track < ActiveRecord::Base
  belongs_to :playlist
  before_create :add_to_spotify_playlist
  before_destroy :remove_from_spotify_playlist

  def spotify_id
    uri.split(':').last
  end

  def spotify
    @spotify ||= RSpotify::Track.find(spotify_id)
  end

  def add_to_spotify_playlist
    playlist.spotify.add_tracks!([spotify])
  end

  def remove_from_spotify_playlist
    playlist.spotify.remove_tracks!([spotify])
  end
end
