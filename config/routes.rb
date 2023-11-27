Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :guesthouses, only: %i[show new create edit update] do
    get 'search', on: :collection
  end

  resources :rooms, only: %i[show new create edit update] do
    resources :custom_prices, only: %i[show new create edit update destroy]
    resources :reservations, only: %i[show new create edit update destroy show_total_price] do
      get 'show_total_price', on: :member
    end
  end

  get 'home/guesthouses_by_city/:city', to: 'home#guesthouses_by_city', as: :guesthouses_by_city

  get "up" => "rails/health#show", as: :rails_health_check
end
