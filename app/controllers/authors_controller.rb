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

  before_action :authenticate_author!
  before_action :redirect_if_not_admin, only: [:index]

  def index
    @authors = Author.all
  end

  def show
    if is_admin?
      @author = Author.find_by_id!(params[:id])
    else
      @author = current_author
    end
  end
end
