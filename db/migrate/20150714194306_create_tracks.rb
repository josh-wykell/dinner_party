class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :uri
      t.string :album
      t.string :contributer

      t.timestamps null: false
    end
  end
end
