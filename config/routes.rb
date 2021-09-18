Rails.application.routes.draw do
  root 'home_page#landing'
  get 'home_page/index'
  get 'tracks/index', to: 'tracks#index
  get '/search', to: 'tracks#search', as: :search
  devise_for :users
  resources :rooms
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
