class AddUriToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :uri, :string
  end
end
