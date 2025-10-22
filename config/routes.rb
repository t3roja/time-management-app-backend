Rails.application.routes.draw do
  # DeviseTokenAuth API reitit
  mount_devise_token_auth_for 'User', at: 'auth'


  # Sovellusreitit
  resources :projects do
    resources :entries, only: [:index, :show, :create, :update, :destroy]
  end

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
