Rails.application.routes.draw do
  root 'home_page#landing'
  get 'home', to: 'home_page#index'
  get '/search', to: 'tracks#search', as: :search
  devise_for :users
  resources :rooms
  resources :tracks, except: %i[update]
end
