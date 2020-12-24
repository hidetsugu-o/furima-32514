Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrartions: 'users/registrations'
  }
  root to: 'items#index'
  resources :items do
    resources :buyers, only: [:index, :create]
  end
end
