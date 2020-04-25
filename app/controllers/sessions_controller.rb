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
      oauth_username = request.env["omniauth.auth"]["extra"]["raw_info"]["login"]

      if @author = Author.find_by(:username => oauth_username)
        session[:author_id] = @author.id
        route_created_session(@author)
      else
        @author = Author.new(:username => oauth_username, :password => SecureRandom.hex)
        @author.save!(:validate => false)
        session[:author_id] = @author.id
        redirect_to edit_author_path(@author)
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
