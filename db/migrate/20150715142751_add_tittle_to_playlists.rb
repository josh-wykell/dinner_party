class AddTittleToPlaylists < ActiveRecord::Migration
  def change
    remove_column :playlists, :contributer
    remove_column :playlists, :track
    add_column :playlists, :name, :string
  end
end
