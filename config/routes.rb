Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :guesthouses, only: %i[show new create edit update]
  resources :rooms, only: %i[show new create edit update]

  get "up" => "rails/health#show", as: :rails_health_check
end
