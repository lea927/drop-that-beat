Rails.application.routes.draw do
<<<<<<< HEAD
  root 'home_page#landing'
  get 'home_page/index'
=======
  get 'tracks/index'
>>>>>>> preview
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
