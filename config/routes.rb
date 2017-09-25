Rails.application.routes.draw do

  root 'companies#index'

  resources :representatives

  resources :companies
  
  post 'company_filters', to: 'companies#get_filtered_companies'
  
  resources :users

  resources :interactions, only: [:new, :create, :show, :edit, :update]

end
