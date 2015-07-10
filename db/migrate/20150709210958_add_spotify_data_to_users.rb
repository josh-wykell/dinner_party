class AddSpotifyDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :data, :json, :default => {}
    remove_column :users, :access_token
  end
end
