Rails.application.routes.draw do
  get "health" => "rails/health#show", as: :rails_health_check

  get "custom_health", to: "application#health"

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      resources :users, only: [ :index, :show, :create ]
    end
  end
end
