Rails.application.routes.draw do

  devise_for :users
  # root 'companies#index'
  root 'main#index'

  resources :representatives

  resources :companies do
    get 'interactions', to: 'interactions#one_company_interactions'
  end

  post 'company_filters', to: 'main#get_filtered_companies'
  post 'representative_filters', to: 'representatives#get_filtered_representatives'
  post 'interaction_filters', to: 'interactions#get_filtered_interactions'

  resources :users

  resources :interactions, except: [:destroy]

end
