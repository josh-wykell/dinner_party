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
    # contributers = playlist_params[:contributers].split(',')
    # playlist_params[:contributers] = contributers
    @playlist = current_user.playlists.create(playlist_params)

    redirect_to '/pages/playing'
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
