Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users
  get 'pages/home'
  get 'pages/about'

  resources :games do
    collection do
      get 'search'
    end
  end
  resources :tickets
end
