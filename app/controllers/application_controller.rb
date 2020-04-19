class ApplicationController < ActionController::Base
  helper_method :current_author

  private

  def current_author
    @current_author ||= Author.find_by(id: session[:author_id])
  end
end
