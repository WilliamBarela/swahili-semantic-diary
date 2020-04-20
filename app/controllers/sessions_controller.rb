class SessionsController < ApplicationController
#         Prefix    Verb        URI Pattern                   Controller#Action
#        sessions   POST        /sessions(.:format)           sessions#create
#     new_session   GET         /sessions/new(.:format)       sessions#new
#         session   DELETE      /sessions/:id(.:format)       sessions#destroy

  def new
    @author = Author.new
  end

  def create
    @author = Author.find_by(email: params[:author][:email]) || Author.new
    if @author && !@author.email.nil? && @author.authenticate(params[:author][:password])
      session[:author_id] = @author.id
      if is_admin?
        redirect_to authors_path
      else
        redirect_to author_stories_path(@author)
      end
    else
      render :new
    end
  end

  def destroy
    session.destroy
    redirect_to login_path
  end
end
