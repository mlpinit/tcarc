Rails.application.routes.draw do
  get :signin,        to: "sessions#new"
  get :signup,        to: "users#new"

  resources :users, only: :create
  resources :sessions, only: :create
  resources :tiles, only: :create
  resources :meeples, only: :create


  root "home#index"
end
