Rails.application.routes.draw do
  # get "movies/filter/hits" => "movies#index", filter: "hits" #only returns 'hit' movies
  # get "movies/filter/flops" => "movies#index", filter: "flops"
  get 'movies/filter/:filter' => "movies#index", as: :filtered_movies #allows custom routes to be returned using :filter parameters, and sets up filtered_movies_path

  resources :genres
  root "movies#index"
  resources :movies do
    resources :reviews #nests reviews inside parent object
    resources :favorites
  end


  resources :users #generates multiple resource routes
  get 'signup' => 'users#new'

  resource :session #generates single resource routes
  
end
