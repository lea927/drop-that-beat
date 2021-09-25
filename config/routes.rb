Rails.application.routes.draw do
  root 'home_page#landing'
  get 'home', to: 'home_page#index'
  get 'tracks_json/:id', to: 'rooms#tracks_json', as: 'tracks_json'
  get '/search', to: 'tracks#search', as: :search
  post '/rooms/:id', to: 'rooms#answer', as: 'answer_room'
  devise_for :users
  resources :rooms
  resources :tracks, except: %i[update]
end
