Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :guesthouses, only: %i[index show new create]

  # get "up" => "rails/health#show", as: :rails_health_check
end
