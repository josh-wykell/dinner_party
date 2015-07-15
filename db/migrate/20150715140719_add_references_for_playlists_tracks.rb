class AddReferencesForPlaylistsTracks < ActiveRecord::Migration
  def change
    remove_column :playlists, :user_id
    add_reference :playlists, :user, index: true, foreign_key: true
    add_reference :tracks, :playlist, index: true, foreign_key: true
  end
end
