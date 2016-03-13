Rails.application.routes.draw do
  get :signin,        to: "sessions#new"
  get :signup,        to: "users#new"

  resources :users, only: :create
  namespace :users do
    get :search, to: "search#index", as: :search
  end

  resources :sessions, only: :create
  resources :tiles, only: :create
  resources :meeples, only: :create

  resources :games, only: [:new, :create, :show] do
    scope module: :games do
      resources :rounds, only: :create
    end
  end

  root "home#index"
end
