Rails.application.routes.draw do

  root 'companies#index'

  resources :representatives

  resources :companies do 
    get 'interactions', to: 'interactions#index'
  end
  
  post 'company_filters', to: 'companies#get_filtered_companies'
  post 'representative_filters', to: 'representatives#get_filtered_representatives'
  
  resources :users

  resources :interactions, only: [:new, :create, :show, :edit, :update]

end
