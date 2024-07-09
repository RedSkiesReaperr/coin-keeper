# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'landing#index'

  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'

    get 'dashboard', to: 'dashboard#index'

    resources :movements
    resources :user_preferences, only: %i[update]
  end
end
