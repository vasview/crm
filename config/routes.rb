Rails.application.routes.draw do

  root 'main#index'

  devise_for :users, skip: :registration

  get "admin/main", to: "admin/main#index", as: :admin_root

  namespace :admin do
    devise_scope :user do
      get "/", to: "sessions#new"
      post "/", to: "sessions#create"
    end

  # devise_for :users, path: '/', skip: :registration
    # devise_scope :admins do
      # get 'sign_in', to: "sessions#new"
    # end
    resources :industries
    resources :users
    resources :job_positions
    resources :services
  end

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

  # resources :users

  resources :interactions, except: [:destroy] do
    post 'filter', on: :collection
    get 'filter', on: :collection
  end
end
