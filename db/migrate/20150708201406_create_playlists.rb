class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.integer :user_id
      t.string :contributer
      t.string :track

      t.timestamps null: false
    end
  end
end
