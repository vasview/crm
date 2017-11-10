Rails.application.routes.draw do

  devise_for :users
  # root 'companies#index'
  root 'main#index'

  resources :representatives do
    post 'filter', on: :collection
    get 'filter', on: :collection
  end

  resources :companies do
    get 'interactions', to: 'interactions#one_company_interactions'
    post 'filter', on: :collection
    get 'filter', on: :collection
  end

  post 'main/filter_companies', to: 'main#filter_companies'

  get 'update_company_options', to: 'companies#update_company_options'
  get 'update_representative_options', to: 'representatives#update_representative_options'

  resources :users

  resources :interactions, except: [:destroy] do
    post 'filter', on: :collection
    get 'filter', on: :collection
  end
end
