Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :registrations, only: [:new, :create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]

  resources :authors, only: [:show, :edit] do
    resources :stories
  end
end
