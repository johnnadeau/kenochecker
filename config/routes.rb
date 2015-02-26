Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users
  get 'pages/home'
  get 'pages/about'

  resources :games
  resources :tickets
end
