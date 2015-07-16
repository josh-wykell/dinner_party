class AddContributersToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :contributers, :text, array: true, default: []
  end
end
