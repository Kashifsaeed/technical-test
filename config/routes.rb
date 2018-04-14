Rails.application.routes.draw do
  root to: 'visitors#index'
  resources :users, only: [:new,:create]
  devise_for :users
  resources :users
  resources :admin

end
