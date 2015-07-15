# t.string   "email"
# t.string   "uid"
# t.string   "access_token"
# @attr [String] birthdate       The user's date-of-birth. This field is only available when the current user has granted access to the *user-read-birthdate* scope.
# @attr [String] country         The country of the user, as set in the user's account profile. An {http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2 ISO 3166-1 alpha-2 country code}. This field is only available when the current user has granted access to the *user-read-private* scope.
# @attr [Hash]   credentials     The credentials generated for the user with OAuth. Includes access token, token type, token expiration time and refresh token. This field is only available when the current user has granted access to any scope.
# @attr [String] display_name    The name displayed on the user's profile. This field is only available when the current user has granted access to the *user-read-private* scope.
# @attr [String] email           The user's email address. This field is only available when the current user has granted access to the *user-read-email* scope.
# @attr [Hash]   followers       Information about the followers of the user
# @attr [Array]  images          The user's profile image. This field is only available when the current user has granted access to the *user-read-private* scope.
# @attr [String] product         The user's Spotify subscription level: "premium", "free", etc. This field is only available when the current user has granted access to the *user-read-private* scope.
# @attr [Hash]   tracks_added_at A hash containing the date and time each track was saved by the user. Note: the hash is filled and updated only when {#saved_tracks} is used.
class User < ActiveRecord::Base
  has_many :playlists
  
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
