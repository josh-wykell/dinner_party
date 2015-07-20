class PlaylistsController < ApplicationController
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
      render :new
    end
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

    def follow
    @playlist = Playlist.find(params[:id])
    current_user.follow(@playlist)
    redirect_to root_path flash[:notice] = "You are now following #{@playlist.name}."
  end

  def unfollow
    @playlist = Playlist.find(params[:id])  
    current_user.stop_following(@playlist)
    redirect_to root_path flash[:notice] = "You are no longer following #{@playlist.name}."
  end
  
  private

  def set_playlist
    @playlist = Playlist.find(params[:id])
  end

  def playlist_params
    params.require(:playlist).permit(:name, :list_contributers)
  end
end
