class AddArtistsToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :artists, :string
  end
end
