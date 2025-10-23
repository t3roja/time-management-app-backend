Rails.application.routes.draw do
  # DeviseTokenAuth
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    resources :users, only: [:index]  # /api/users
  end

  resources :projects do
    resources :entries, only: [:index, :show, :create, :update, :destroy]
  end

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end