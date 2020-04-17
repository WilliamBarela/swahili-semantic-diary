class RegistrationsController < ApplicationController
#             Prefix         Verb         URI Pattern                      Controller#Action
#         registrations      POST         /registrations(.:format)         registrations#create
#      new_registration      GET          /registrations/new(.:format)     registrations#new
#          registration      DELETE       /registrations/:id(.:format)     registrations#destroy

  def new
    @author = Author.new
  end

  def create
  end

  def destroy
  end
end
