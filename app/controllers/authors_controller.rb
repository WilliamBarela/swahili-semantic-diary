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
  before_action :redirect_if_not_admin, only: [:index, :destroy]

  def index
    @authors = Author.all
  end

  def show
    @author = set_author_if_admin(params[:id])
  end

  def edit
    @author = set_author_if_admin(params[:id])
  end

  def update
    @author = Author.find_by_id!(params[:id])
    params[:author][:admin] = false unless is_admin?

    if @author.update(author_params)
      redirect_to author_stories_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    Author.find_by_id!(params[:id]).destroy
    redirect_to authors_path
  end

  private
  def author_params
    params.require(:author).permit(:first_name, :last_name, :email, :admin)
  end
end
