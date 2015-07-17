class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]
  require 'rspotify'

  def index
    @playlists = current_user.playlists 
    @playlist = Playlist.new
  end

  def show
  end
  
  def create
    @playlists = Playlist.all
    @playlist = current_user.playlists.create(playlist_params)

    redirect_to playlist_path
  end

  def edit
  end

  def update
    @playlists = Playlist.all
  end

  def destroy
    @playlists = Playlist.all
    @playlist.destroy
  end
  
  private

  def set_playlist
    @playlist = Playlist.find(params[:id])
  end

  def playlist_params
    params.require(:playlist).permit(:name, :list_contributers)
  end
end
