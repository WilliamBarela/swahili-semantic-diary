class SessionsController < ApplicationController
#         Prefix    Verb        URI Pattern                   Controller#Action
#        sessions   POST        /sessions(.:format)           sessions#create
#     new_session   GET         /sessions/new(.:format)       sessions#new
#         session   DELETE      /sessions/:id(.:format)       sessions#destroy

  def new
    @author = Author.new
  end

  def create
    @author = Author.find_by(email: params[:author][:email])
    if @author && @author.authenticate(params[:author][:password])
      session[:author_id] = @author.id
      redirect_to new_author_story_path(@author)
    else
      render :new
    end
  end

  def destroy
  end
end
