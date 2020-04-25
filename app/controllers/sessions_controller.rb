class SessionsController < ApplicationController
#         Prefix    Verb        URI Pattern                   Controller#Action
#        sessions   POST        /sessions(.:format)           sessions#create
#     new_session   GET         /sessions/new(.:format)       sessions#new
#         session   DELETE      /sessions/:id(.:format)       sessions#destroy

  def new
    @author = Author.new
  end

  def create
    if auth_hash = request.env["omniauth.auth"]
      @author = Author.find_or_create_by_omniauth(auth_hash)
      session[:author_id] = @author.id

      if @author.email.nil?
        redirect_to edit_author_path(@author)
      else
        route_created_session(@author)
      end
    else
      @author = Author.find_by(email: params[:author][:email]) || Author.new

      if non_nil_author_authenticates(@author, params)
        session[:author_id] = @author.id
        route_created_session(@author)
      else
        flash[:alert] = "Email or password is incorrect"
        redirect_to login_path
      end
    end
  end

  def destroy
    session.destroy
    redirect_to login_path
  end
end
