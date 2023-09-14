require 'sidekiq/web'

Mycareerpal::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # root to: 'static_pages#home'
  root to: 'companies#index'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, controllers: {confirmations: 'confirmations', registrations: 'registrations', omniauth_callbacks: 'omniauth_callbacks'}

  devise_scope :user do
    put "/confirm" => "confirmations#confirm"
  end

  get '/about', controller: :static_pages, action: :about
  get '/terms', controller: :static_pages, action: :terms
  get '/privacy', controller: :static_pages, action: :privacy
  get '/welcome', controller: :static_pages, action: :welcome
  get '/landing', controller: :static_pages, action: :landing
  get '/thank_you', controller: :static_pages, action: :thank_you
  get '/ceo', controller: :companies, action: :index, ceo: true

  resources :positions do 
    get :past, on: :collection, action: :index, type: :past
    get :current, on: :collection, action: :index, type: :current
    get :end, on: :member
  end

  resources :projects do
    get :complete, on: :member
  end

  resources :compensations, path: 'salary' do
    get :charts, on: :collection, as: :charts
    get :compare, on: :collection, as: :compare
  end

  resources :industries do
    get :search, on: :collection
    get :areas, on: :collection
    get :bls_industries, on: :collection, as: :bls
    get :update_tweets, on: :collection, as: :update_tweets
  end

  resources :roles do
    get :search, on: :collection
    get :update_tweets, on: :collection, as: :update_tweets
  end

  resources :occupations do
    get :search, on: :collection
    get :areas, on: :collection
    get :titles, on: :collection
  end

  resources :market_salaries do
    get :search, on: :collection
    get :companies, on: :collection
    get :titles, on: :collection
  end

  resources :companies do
    get :search, on: :collection
    get :connections, on: :collection
  end

  resources :categories do
    get :search, on: :collection
  end

  resources :user_lists do
    get 'add/:company_id', on: :member, action: :add
    get 'remove/:company_id', on: :member, action: :remove
  end

  resources :user_list_line_items, only: [:destroy]

  resource :feedback, only: [:create]
  # resources :assets
  resources :grades
  resources :divisions
  resources :people
  resources :teams
  resources :terms
  resources :educations
  resources :currencies, only: [:index]
  resources :goals
  resources :desired_jobs
  resources :research, only: [:index]

  get '/education', action: :index, controller: :educations

end
