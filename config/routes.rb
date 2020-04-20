Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'registrations#new'

  get 'sign-up', to: 'registrations#new'
  post 'sign-up', to: 'registrations#create'
  delete 'delete-account/:author_id', to: 'registrations#destroy'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  # resources :sessions, only: [:new, :create, :destroy]

  resources :authors, only: [:index, :show, :edit, :update, :destroy] do
    resources :stories
  end
end
