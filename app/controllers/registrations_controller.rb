class RegistrationsController < ApplicationController
#             Prefix         Verb         URI Pattern                      Controller#Action
#         registrations      POST         /registrations(.:format)         registrations#create
#      new_registration      GET          /registrations/new(.:format)     registrations#new
#          registration      DELETE       /registrations/:id(.:format)     registrations#destroy

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      session[:author_id] = @author.id
      redirect_to new_author_story_path(@author)
    else
      render :new
    end
  end

  def destroy
  end

  private
  def author_params
    params.require(:author).permit(:first_name, :last_name, :email, :password)
  end
end
