class AddContributersToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :contributers, :json
  end
end
