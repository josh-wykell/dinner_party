class PlaylistsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]
  require 'rspotify'

  def index
    if params[:search]
      @playlists = Playlist.search(params[:search]).order("created_at DESC")
    else
      @playlists = current_user.playlists
    end 
    @playlist = Playlist.new
  end

  def show
  end
  
  def create
    @playlists = Playlist.all
    @playlist = current_user.playlists.create(playlist_params)

    if @playlist.save
      redirect_to @playlist
    else
      redirect_to root_path, :notice => "We were unable to create your playlist. Please make sure to include a name for your list, and at least one contributor."
    end
  end

  def edit
  end

  def update
    @playlists = Playlist.all
  end

  def destroy
    @playlist.destroy
    redirect_to root_path
  end

  def follow
    @playlist = Playlist.find(params[:id])
    current_user.follow(@playlist)
    redirect_to root_path, :notice => "You are now following #{@playlist.name}."
  end

  def unfollow
    @playlist = Playlist.find(params[:id])  
    current_user.stop_following(@playlist)
    redirect_to root_path :notice => "You are no longer following #{@playlist.name}."
  end
  
  private

  def set_playlist
    @playlist = Playlist.find(params[:id])
  end

  def playlist_params
    params.require(:playlist).permit(:name, :list_contributers)
  end
end
