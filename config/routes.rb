Rails.application.routes.draw do

  devise_for :users
  # root 'companies#index'
  root 'main#index'

  resources :representatives

  resources :companies do
    get 'interactions', to: 'interactions#one_company_interactions'
    post 'filter', on: :collection
    get 'filter', on: :collection
  end

  post 'main/filter_companies', to: 'main#filter_companies'
  post 'representative_filters', to: 'representatives#filter_representatives'
  post 'interaction_filters', to: 'interactions#filter_interactions'

  resources :users

  resources :interactions, except: [:destroy]

end
