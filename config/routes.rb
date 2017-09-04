Rails.application.routes.draw do

  root 'companies#index'

  resources :representatives

  resources :companies

  resources :users

  resources :interactions, only: [:new, :create, :show, :edit, :update]

end
