Rails.application.routes.draw do
  root 'home_page#landing'
  get 'home', to: 'home_page#index'
  get 'tracks', to: 'tracks#index'
  get 'tracks_json/:id', to: 'rooms#tracks_json', as: 'tracks_json'
  get '/search', to: 'tracks#search', as: :search
  devise_for :users
  resources :rooms
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
