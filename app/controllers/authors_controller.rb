class AuthorsController < ApplicationController
  #      Prefix      Verb         URI Pattern                   Controller#Action
  #      authors     GET          /authors(.:format)               authors#index
  #                  POST         /authors(.:format)               authors#create
  #   new_author     GET          /authors/new(.:format)           authors#new
  #  edit_author     GET          /authors/:id/edit(.:format)      authors#edit
  #       author     GET          /authors/:id(.:format)           authors#show
  #                  PATCH        /authors/:id(.:format)           authors#update
  #                  PUT          /authors/:id(.:format)           authors#update
  #                  DELETE       /authors/:id(.:format)           authors#destroy

  before_action :is_admin?, only: [:index]

  def index
  end
end
