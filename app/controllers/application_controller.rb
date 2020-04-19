class ApplicationController < ActionController::Base
  helper_method :current_author, :logged_in?

  private

  def current_author
    @current_author ||= Author.find_by(id: session[:author_id])
  end

  def logged_in?
    !!current_author
  end
end
