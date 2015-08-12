Rails.application.routes.draw do
  get "/auth/spotify/callback" => "sessions#create"
  get "/signout" => "sessions#destroy", :as => :signout
  get "/spotify/search" => "home#spotify_search"
  resources :playlists do 
    member do
      get :follow
      get :unfollow
    end
    resources :tracks, only: [:create, :destroy] do
      collection do
        get 'search'
      end
    end
  end
  
  root 'home#index'

end
