Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'sign-up', to: 'registrations#new'
  post 'sign-up', to: 'registrations#create'
  delete 'delete-account/:author_id', to: 'registrations#destroy'

  resources :sessions, only: [:new, :create, :destroy]

  resources :authors, only: [:show, :edit] do
    resources :stories
  end
end
