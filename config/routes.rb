Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'registrations#new'

  get 'sign-up', to: 'registrations#new'
  post 'sign-up', to: 'registrations#create'
  delete 'delete-account/:author_id', to: 'registrations#destroy'

  get 'login', to: 'sessions#new'
  get 'auth/:provider/callback', to: 'sessions#create'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  resources :authors, only: [:show, :edit, :update, :destroy] do
    resources :stories, except: [:show]
  end

  resources :stories, only: [:show] do
    resources :words, only: [:new, :create]
  end

  scope '/admin' do
    resources :authors, only: [:index]
  end

  namespace :admin do
    resources :stats, only: [:index]
  end
end
