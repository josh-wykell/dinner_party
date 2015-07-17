class Playlist < ActiveRecord::Base
  belongs_to :user
  has_many :tracks

  def list_contributers=(names)
    self.contributers = names.split(",")
  end

  def list_contributers
    self.contributers.try(:join, ", ")
  end

  def current_contributer
    self.contributers.fetch( tracks.size % contributers.size )
  end

  
  # # TODO: add spotify_id:string to playlists
  # def spotify
  #   @spotify ||= RSpotify::Playlist.find(user.uid, spotify_id)
  # end
end
