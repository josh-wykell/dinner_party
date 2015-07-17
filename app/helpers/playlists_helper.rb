module PlaylistsHelper

  def artist_for_track(track)
    track.artists.map(&:name).to_sentence
  end
end
