Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :guesthouses, only: %i[show new create edit update]
  resources :rooms do
    resources :custom_prices, only: %i[show new create edit update]
  end

  get 'home/guesthouses_by_city/:city', to: 'home#guesthouses_by_city', as: :guesthouses_by_city

  get "up" => "rails/health#show", as: :rails_health_check
end
