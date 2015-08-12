
class User < ActiveRecord::Base
  has_many :playlists
    acts_as_follower

  def display_name
    name.blank? ? uid : name
  end

  def spotify
    @spotify ||= RSpotify::User.new(data)
  end

  def self.from_spotify(auth)
    where(uid: auth.id).first_or_create.tap do |u|
      u.name         = auth.display_name
      u.email        = auth.email
      u.avatar_url   = auth.images.first.try(:url)
      u.data         = auth.to_hash
      u.save!
    end
  end
end
