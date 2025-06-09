Rails.application.routes.draw do
  get "health" => "rails/health#show", as: :rails_health_check

  get "custom_health", to: "application#health"

  root "root#index"

  namespace :api do
    namespace :v1 do
      namespace :users do
        resource :profile, only: [ :show, :create ]
      end
    end
  end
end
