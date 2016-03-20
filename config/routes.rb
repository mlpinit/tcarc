Rails.application.routes.draw do
  get :signin,        to: "sessions#new"
  get :signup,        to: "users#new"
  delete :signout,    to: "sessions#destroy"

  resources :users, only: :create
  namespace :users do
    get :search, to: "search#index", as: :search, defaults: { format: 'json' }
  end

  resources :sessions, only: :create
  resources :tiles, only: :create
  resources :meeples, only: :create

  resources :games, only: [:new, :create, :show, :index] do
    scope module: :games do
      resource :board, only: :show
      resources :rounds, only: :create
    end
  end

  root "home#index"

  mount ActionCable.server => "/cable"
end
