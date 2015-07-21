class Playlist < ActiveRecord::Base
  belongs_to :user
  has_many :tracks, :dependent => :destroy
  before_create :create_spotify_playlist
  acts_as_followable

  def create_spotify_playlist
    playlist = user.spotify.create_playlist!(name)
    self.uri = playlist.uri
  end

  def list_contributers=(names)
    self.contributers = names.split(",")
  end

  def list_contributers
    self.contributers.try(:join, ", ")
  end

  def current_contributer
    self.contributers.fetch( tracks.size % contributers.size )
  end

  def self.search(query)
    where("name ilike ?", "%#{query}%") 
  end
  
  def spotify_id
    uri.split(':').last
  end

  def spotify
    @spotify ||= RSpotify::Playlist.find(user.spotify.id, spotify_id)
  end

  def embed_url
    track_ids = tracks.map(&:spotify_id).join(',')
    "https://embed.spotify.com/?uri=spotify:trackset:#{URI.escape(name)}:#{track_ids}&theme=white&view=list"
  end
end
