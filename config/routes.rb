Rails.application.routes.draw do
  root 'home_page#landing'
  get 'home_page/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
